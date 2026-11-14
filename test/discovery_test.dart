import 'dart:async';

import 'package:cat_tinder/state/discovery.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'internal/fake_transport.dart';

Future<void> settleUntil(bool Function() predicate) async {
  for (var i = 0; i < 100; i++) {
    if (predicate()) return;
    await Future<void>.delayed(const Duration(milliseconds: 2));
  }
  fail('The expected state did not settle.');
}

void main() {
  late FakeTransport transport;
  late ProviderContainer container;
  late Discovery actions;
  late Dio client;
  setUp(() {
    transport = FakeTransport();
    final api = transport.attach();
    client = api.client;
    container = ProviderContainer(
      overrides: [discoveryProvider.overrideWith(() => Discovery(api: api))],
    );
    actions = container.read(discoveryProvider.notifier);
  });
  tearDown(() => container.dispose());
  DiscoveryState state() => container.read(discoveryProvider);

  test(
    'preloads front, appends once, and never forwards API key to photographs',
    () async {
      await settleUntil(
        () =>
            state().queue.take(3).length == 3 &&
            state().queue.take(3).every((e) => e.bytes != null),
      );
      final head = state().current!;
      await Future.wait([actions.refill(), actions.refill(), actions.refill()]);
      expect(transport.searches, 2);
      expect(state().queue.length, 12);
      expect(state().current!.number, head.number);
      expect(state().current!.image.id, head.image.id);
      expect(
        transport.requests
            .where((r) => r.uri.host == 'images.example')
            .every((r) => !r.headers.containsKey('x-api-key')),
        isTrue,
      );
    },
  );

  test('slow failed vote does not block advancement or accept the old encounter twice', () async {
    await settleUntil(() => state().current?.bytes != null);
    final head = state().current!;
    transport.voteDelay = Completer<void>();
    final failedVote = Completer<void>();
    client.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.requestOptions.path == 'votes') failedVote.complete();
          handler.next(error);
        },
      ),
    );
    actions.decide(head.number, true);
    actions.decide(head.number, false);
    expect(state().queue.length, 5);
    expect(state().current!.number, isNot(head.number));
    await settleUntil(() => transport.votes.isNotEmpty);
    expect(transport.votes, [
      {'image_id': head.image.id, 'value': 1},
    ]);
    transport.voteDelay!.complete();
    await failedVote.future;
    // Drain the continuations that deliver the observed failure to the mutation.
    await pumpEventQueue();
    expect(state().error, isNull);
    expect(transport.votes.length, 1);
  });

  test('refill failure retains cards, exhaustion exposes error, retry does not replay votes', () async {
    await settleUntil(
      () => state().queue.length == 6 && state().current?.bytes != null,
    );
    transport.failRefill = true;
    final queued = state().queue.map((entry) => entry.number).toList();
    await actions.refill();
    expect(state().error, isNotNull);
    expect(state().queue.map((entry) => entry.number), queued);
    while (state().queue.isNotEmpty) {
      await settleUntil(() => state().current?.bytes != null);
      actions.decide(state().current!.number, false);
    }
    await settleUntil(() => state().error != null);
    expect(state().queue, isEmpty);
    await settleUntil(() => transport.votes.length == 6);
    transport.failRefill = false;
    await actions.refill();
    expect(state().queue.length, 6);
    expect(transport.votes.length, 6);
    expect(state().error, isNull);
  });

  test(
    'photograph skip never votes and same-image retry is available',
    () async {
      transport.failPhotos = true;
      await settleUntil(() => state().current?.photoFailed == true);
      final first = state().current!;
      actions.decide(first.number, true);
      expect(state().current!.number, first.number);
      transport.failPhotos = false;
      actions.retryPhotograph(first.number);
      await settleUntil(() => state().current?.bytes != null);
      expect(state().current!.image.id, first.image.id);
      actions.photographFailed(first.number);
      actions.skip(first.number);
      expect(state().current!.number, isNot(first.number));
      expect(transport.votes, isEmpty);
    },
  );

  test(
    'repeated image IDs are independent encounters and negative vote uses -1',
    () async {
      transport.respond = (request) async {
        if (request.path == 'images/search') {
          return jsonBody(List.generate(6, (_) => imageJson('same')));
        }
        if (request.path == 'votes') {
          transport.votes.add(Map<String, dynamic>.from(request.data as Map));
          return jsonBody({});
        }
        return ResponseBody.fromBytes(pixel, 200);
      };
      await settleUntil(() => state().queue.length == 6);
      expect(state().queue.map((e) => e.number).toSet().length, 6);
      await settleUntil(() => state().current?.bytes != null);
      actions.decide(state().current!.number, false);
      await settleUntil(() => state().current?.bytes != null);
      actions.decide(state().current!.number, true);
      await settleUntil(() => transport.votes.length == 2);
      expect(transport.votes.map((v) => v['value']), [-1, 1]);
    },
  );

  test(
    'mixed batches keep valid records in order without suppressing duplicates',
    () async {
      final invalidFirstBreed = imageJson('invalid-breed')
        ..['breeds'] = [
          null,
          {'id': 'beng', 'name': 'Bengal'},
        ];
      transport.respond = (request) async {
        if (request.path == 'images/search') {
          transport.searches++;
          return jsonBody([
            null,
            imageJson('first'),
            42,
            {'id': 'missing-fields'},
            imageJson('duplicate'),
            invalidFirstBreed,
            imageJson('empty-first-breed')
              ..['breeds'] = [
                {'id': '', 'name': ''},
                {'id': 'beng', 'name': 'Bengal'},
              ],
            imageJson('invalid-url')..['url'] = false,
            imageJson('duplicate'),
            'not an image',
            imageJson('last'),
          ]);
        }
        return ResponseBody.fromBytes(pixel, 200);
      };
      await settleUntil(() => state().queue.isNotEmpty && !state().refilling);
      expect(state().queue.map((e) => e.image.id), [
        'first',
        'duplicate',
        'duplicate',
        'last',
      ]);
      expect(state().current!.image.breeds.map((breed) => breed.id), [
        'abys',
        'beng',
      ]);
      expect(state().error, isNull);
      expect(transport.searches, 1);
      expect(transport.votes, isEmpty);
    },
  );

  for (final response in <String, Object>{
    'entirely unusable list': [
      null,
      42,
      {},
      imageJson('no-breed')..['breeds'] = [],
    ],
    'object instead of list': imageJson('not-a-list'),
  }.entries) {
    test(
      '${response.key} fails recoverably and retry accepts valid records',
      () async {
        transport.respond = (request) async {
          if (request.path == 'images/search') {
            transport.searches++;
            return jsonBody(response.value);
          }
          return ResponseBody.fromBytes(pixel, 200);
        };
        await settleUntil(() => state().error != null && !state().refilling);
        expect(state().queue, isEmpty);
        expect(transport.searches, 1);
        transport.respond = null;
        await actions.refill();
        expect(state().queue.length, 6);
        expect(state().error, isNull);
        expect(transport.votes, isEmpty);
      },
    );
  }

  test('disposing session cancels pending HTTP', () async {
    final pending = Completer<void>();
    transport.respond = (request) async {
      await pending.future;
      return jsonBody(List.generate(6, (_) => imageJson('late')));
    };
    await settleUntil(() => transport.requests.isNotEmpty);
    container.dispose();
    expect(transport.requests.first.cancelToken!.isCancelled, isTrue);
    pending.complete();
    await pumpEventQueue();
  });
}
