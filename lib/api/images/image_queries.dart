import 'dart:typed_data';

import 'package:cached_query/cached_query.dart';
import 'package:dio/dio.dart';

import '../cat_api.dart';
import 'cat_image.dart';

class ImageQueries {
  ImageQueries(
    this.api,
    this.cache, {
    required void Function(List<CatImage>) onBatch,
    required void Function(Object) onFailure,
  }) {
    refill = Query<List<CatImage>>(
      key: 'discovery-refill',
      cache: cache,
      config: QueryConfig(
        ignoreCacheDuration: true,
        refetchOnResume: false,
        refetchOnConnection: false,
      ),
      queryFn: () async {
        api.requireAccess();
        final response = await api.request(
          (token) => api.client.get<dynamic>(
            'images/search',
            queryParameters: {'has_breeds': 1, 'limit': 10, 'order': 'RANDOM'},
            cancelToken: token,
          ),
        );
        if (response.data is! List) {
          throw const ContentFailure(
            'The cat service returned unreadable data. Please retry.',
          );
        }
        final images = (response.data as List)
            .whereType<Map<String, dynamic>>()
            .map(CatImage.fromJson)
            .where((image) => image.usable)
            .toList();
        if (images.isEmpty) {
          throw const ContentFailure(
            'No usable cats were returned. Please try again.',
          );
        }
        return images;
      },
      onSuccess: onBatch,
      onError: (error) => onFailure(error as Object),
    );
  }

  final CatApi api;
  final CachedQuery cache;
  late final Query<List<CatImage>> refill;

  Query<Uint8List> photograph(String url) => Query<Uint8List>(
    key: ['photograph', url],
    cache: cache,
    config: QueryConfig(
      staleDuration: const Duration(minutes: 5),
      cacheDuration: const Duration(seconds: 30),
      refetchOnResume: false,
      refetchOnConnection: false,
    ),
    queryFn: () async {
      final result = await api.request(
        (token) => api.photographs.get<List<int>>(
          url,
          options: Options(responseType: ResponseType.bytes),
          cancelToken: token,
        ),
      );
      if (result.data == null || result.data!.isEmpty) {
        throw const ContentFailure('This photograph is unavailable.');
      }
      return Uint8List.fromList(result.data!);
    },
  );
}
