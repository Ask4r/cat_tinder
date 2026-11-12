import 'dart:async';

import 'package:cached_query/cached_query.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

import 'package:cat_tinder/api/cat_api.dart';
import 'package:cat_tinder/api/images/cat_image.dart';
import 'package:cat_tinder/api/images/image_queries.dart';
import 'package:cat_tinder/api/votes/vote.dart';

final discoveryProvider = NotifierProvider<Discovery, DiscoveryState>(
  Discovery.new,
);

class Encounter {
  const Encounter(
    this.number,
    this.image, {
    this.bytes,
    this.photoFailed = false,
    this.photoReady = false,
  });
  final int number;
  final CatImage image;
  final Uint8List? bytes;
  final bool photoFailed;
  final bool photoReady;
}

class DiscoveryState {
  DiscoveryState({
    List<Encounter> queue = const [],
    this.refilling = false,
    this.error,
  }) : queue = List.unmodifiable(queue);
  final List<Encounter> queue;
  final bool refilling;
  final String? error;
  Encounter? get current => queue.isEmpty ? null : queue.first;
}

class Discovery extends Notifier<DiscoveryState> {
  Discovery({CatApi? api}) : _providedApi = api;
  final CatApi? _providedApi;
  late CatApi _api;
  late CachedQuery _cache;
  late ImageQueries _images;
  late Mutation<void, Vote> _votes;
  final _preparing = <int>{};
  var _sequence = 0;
  var _alive = true;

  @override
  DiscoveryState build() {
    _api = _providedApi ?? CatApi();
    _cache = CachedQuery.asNewInstance();
    _images = ImageQueries(_api, _cache, onBatch: _append, onFailure: _failed);
    _votes = imageVotes(_api);
    ref.onDispose(() {
      _alive = false;
      _api.close();
      unawaited(_cache.dispose());
    });
    scheduleMicrotask(refill);
    return DiscoveryState();
  }

  Future<void> refill() async {
    if (!_alive || state.refilling) return;
    state = DiscoveryState(queue: state.queue, refilling: true);
    // Refill is an explicit new random batch, never a cached-result replay.
    await _images.refill.refetch();
    if (!_alive) return;
    state = DiscoveryState(queue: state.queue, error: state.error);
    if (state.queue.length <= 3 && state.error == null) {
      scheduleMicrotask(refill);
    }
  }

  void _append(List<CatImage> images) {
    if (!_alive) return;
    state = DiscoveryState(
      queue: [
        ...state.queue,
        ...images.map((image) => Encounter(_sequence++, image)),
      ],
      refilling: true,
    );
    _prepareFront();
  }

  void _failed(Object error) {
    if (_alive) {
      state = DiscoveryState(
        queue: state.queue,
        refilling: true,
        error: contentError(error),
      );
    }
  }

  void _prepareFront() {
    // Web photographs use Flutter’s HTML image provider, not a CORS byte fetch.
    if (kIsWeb) return;
    for (final encounter in state.queue.take(3)) {
      if (encounter.bytes == null &&
          !encounter.photoFailed &&
          _preparing.add(encounter.number)) {
        unawaited(_prepare(encounter));
      }
    }
  }

  Future<void> _prepare(Encounter encounter, {bool retry = false}) async {
    final query = _images.photograph(encounter.image.url);
    final result = await (retry ? query.refetch() : query.fetch());
    _preparing.remove(encounter.number);
    if (!_alive) return;
    _replace(
      encounter.number,
      bytes: result.isSuccess ? result.data : null,
      failed: !result.isSuccess,
    );
  }

  void _replace(
    int number, {
    Uint8List? bytes,
    bool failed = false,
    bool ready = false,
  }) {
    state = DiscoveryState(
      queue: state.queue
          .map(
            (entry) => entry.number == number
                ? Encounter(
                    number,
                    entry.image,
                    bytes: bytes,
                    photoFailed: failed,
                    photoReady: ready || bytes != null,
                  )
                : entry,
          )
          .toList(),
      refilling: state.refilling,
      error: state.error,
    );
  }

  void retryPhotograph(int number) {
    final current = state.current;
    if (current == null || current.number != number) return;
    if (kIsWeb) {
      _replace(number);
      return;
    }
    if (!_preparing.add(number)) {
      return;
    }
    _replace(number);
    unawaited(_prepare(current, retry: true));
  }

  void photographLoaded(int number) {
    if (_alive &&
        kIsWeb &&
        state.current?.number == number &&
        !state.current!.photoFailed) {
      _replace(number, ready: true);
    }
  }

  void photographFailed(int number) {
    if (_alive && state.current?.number == number) {
      _replace(number, failed: true);
    }
  }

  void decide(int number, bool liked) {
    final current = state.current;
    if (current == null ||
        current.number != number ||
        !current.photoReady ||
        current.photoFailed) {
      return;
    }
    _advance();
    unawaited(_votes.mutate(Vote(current.image.id, liked)));
  }

  void skip(int number) {
    if (state.current?.number == number && state.current!.photoFailed) {
      _advance();
    }
  }

  void _advance() {
    state = DiscoveryState(
      queue: state.queue.skip(1).toList(),
      refilling: state.refilling,
      error: state.error,
    );
    _prepareFront();
    // A failed refill is retried explicitly after exhaustion, not on every swipe.
    if (state.queue.length <= 3 && state.error == null) refill();
  }
}
