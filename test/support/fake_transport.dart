import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cat_tinder/api/cat_api.dart';
import 'package:dio/dio.dart';

final pixel = base64Decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR4nGO4s6XiPwAHgAMINIH6RAAAAABJRU5ErkJggg==',
);

Map<String, dynamic> imageJson(String id) => {
  'id': id,
  'url': 'https://images.example/$id.png',
  'breeds': [
    {'id': 'abys', 'name': 'Abyssinian'},
    {'id': 'beng', 'name': 'Bengal'},
  ],
};

class FakeTransport implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  Future<ResponseBody> Function(RequestOptions)? respond;
  int searches = 0;
  final votes = <Map<String, dynamic>>[];
  bool failRefill = false;
  bool failPhotos = false;
  Completer<void>? voteDelay;

  CatApi attach() {
    final api = CatApi();
    api.client.options.baseUrl = 'https://api.example/v1/';
    api.client.options.headers['x-api-key'] = 'test-key';
    api.client.httpClientAdapter = this;
    api.photographs.httpClientAdapter = this;
    return api;
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? body,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (respond != null) return respond!(options);
    if (options.path == 'images/search') {
      searches++;
      if (failRefill) return jsonBody({'message': 'unavailable'}, 503);
      return jsonBody(List.generate(6, (i) => imageJson('cat-$searches-$i')));
    }
    if (options.path == 'votes') {
      votes.add(Map<String, dynamic>.from(options.data as Map));
      await voteDelay?.future;
      return jsonBody({'message': 'unavailable'}, 503);
    }
    return failPhotos ? jsonBody({}, 503) : ResponseBody.fromBytes(pixel, 200);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody jsonBody(Object data, [int status = 200]) =>
    ResponseBody.fromString(
      jsonEncode(data),
      status,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
