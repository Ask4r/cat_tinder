import 'dart:async';

import 'package:dio/dio.dart';

const contentTimeout = Duration(seconds: 6);

class ContentFailure implements Exception {
  const ContentFailure(this.message);
  final String message;
}

String contentError(Object error) {
  if (error is ContentFailure) return error.message;
  if (error is DioException &&
      [401, 403].contains(error.response?.statusCode)) {
    return 'Cat service access is unavailable. Please try again later.';
  }
  return "We couldn't load this cat. Check your connection and try again.";
}

class CatApi {
  CatApi() {
    client = Dio(
      BaseOptions(
        connectTimeout: contentTimeout,
        receiveTimeout: contentTimeout,
      ),
    );
    photographs = Dio(
      BaseOptions(
        connectTimeout: contentTimeout,
        receiveTimeout: contentTimeout,
      ),
    );
    const configuredKey = String.fromEnvironment('CAT_API_KEY');
    final key = configuredKey.trim();
    if (key.isNotEmpty) {
      client.options.headers['x-api-key'] = key;
    }

    const configuredBase = String.fromEnvironment('CAT_API_BASE_URL');
    final base = configuredBase.trim();
    if (base.isEmpty) return;
    final uri = Uri.tryParse(base);
    if (uri != null && uri.scheme == 'https' && uri.hasAuthority) {
      client.options.baseUrl = '${base.replaceAll(RegExp(r'/+$'), '')}/';
    }
    // Absent or invalid configuration leaves the transport unconfigured.
    // requireAccess rejects it before an endpoint request can be made.
  }

  late final Dio client;
  // Never forward the API key to image hosts.
  late final Dio photographs;
  final _tokens = <CancelToken>{};
  bool _closed = false;

  Future<T> request<T>(Future<T> Function(CancelToken token) operation) async {
    if (_closed) throw const ContentFailure('Cat service is unavailable.');
    final token = CancelToken();
    _tokens.add(token);
    try {
      return await operation(token).timeout(
        contentTimeout,
        onTimeout: () {
          token.cancel('Request deadline exceeded');
          throw const ContentFailure(
            'Loading took too long. Please try again.',
          );
        },
      );
    } finally {
      _tokens.remove(token);
    }
  }

  void requireAccess() {
    final key = client.options.headers['x-api-key'];
    if (key is! String || key.isEmpty) {
      throw const ContentFailure(
        'Cat service access is not configured. Please try again later.',
      );
    }
    final base = Uri.tryParse(client.options.baseUrl);
    if (base == null || base.scheme != 'https' || !base.hasAuthority) {
      throw const ContentFailure(
        'Cat service access is incorrectly configured.',
      );
    }
  }

  void close() {
    _closed = true;
    for (final token in _tokens.toList()) {
      token.cancel('Application session ended');
    }
    client.close(force: true);
    photographs.close(force: true);
  }
}
