import 'package:cached_query/cached_query.dart';

import '../cat_api.dart';

class Vote {
  const Vote(this.imageId, this.liked);
  final String imageId;
  final bool liked;
}

Mutation<void, Vote> imageVotes(CatApi api) => Mutation<void, Vote>(
  mutationFn: (vote) async {
    api.requireAccess();
    await api.request(
      (token) => api.client.post<void>(
        'votes',
        data: {'image_id': vote.imageId, 'value': vote.liked ? 1 : -1},
        cancelToken: token,
      ),
    );
  },
  // Mutation catches failures. No retry, invalidation, rollback, or UI feedback.
);
