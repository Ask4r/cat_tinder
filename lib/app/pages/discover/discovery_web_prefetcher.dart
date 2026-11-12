import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:cat_tinder/state/discovery.dart';

import 'web_photograph.dart';

/// Warms Flutter's browser image cache for the front of the discovery queue.
class DiscoveryWebPrefetcher {
  final _prefetched = <String>{};

  void update(BuildContext context, DiscoveryState discovery) {
    if (!kIsWeb) return;
    final urls = discovery.queue
        .take(3)
        .map((entry) => entry.image.url)
        .toSet();
    _prefetched.retainAll(urls);
    for (final url in urls) {
      if (!_prefetched.add(url)) continue;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) return;
        unawaited(
          precacheImage(webPhotograph(url), context, onError: (_, _) {}),
        );
      });
    }
  }
}
