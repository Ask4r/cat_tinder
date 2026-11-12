import 'package:cat_tinder/api/cat_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('missing build configuration rejects API access without defaults', () {
    // This suite runs without service configuration; never use real credentials.
    expect(
      const String.fromEnvironment('CAT_API_KEY'),
      isEmpty,
      reason: 'Run this suite without service dart-defines.',
    );
    expect(
      const String.fromEnvironment('CAT_API_BASE_URL'),
      isEmpty,
      reason: 'Run this suite without service dart-defines.',
    );
    final api = CatApi();
    addTearDown(api.close);

    expect(api.requireAccess, throwsA(isA<ContentFailure>()));
    expect(api.client.options.baseUrl, isEmpty);
    expect(api.client.options.headers.containsKey('x-api-key'), isFalse);
  });
}
