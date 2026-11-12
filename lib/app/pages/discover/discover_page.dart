import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cat_tinder/state/discovery.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/page_header.dart';

import 'card_foreground_column.dart';
import 'discovery_stage.dart';
import 'discovery_web_prefetcher.dart';

class DiscoverPage extends ConsumerStatefulWidget {
  const DiscoverPage({super.key});

  @override
  ConsumerState<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends ConsumerState<DiscoverPage> {
  final _prefetcher = DiscoveryWebPrefetcher();

  @override
  Widget build(BuildContext context) {
    final discovery = ref.watch(discoveryProvider);
    final actions = ref.read(discoveryProvider.notifier);
    _prefetcher.update(context, discovery);
    return CardForegroundColumn(
      cardIndex: 2,
      children: [
        const PageHeader(
          title: 'Discover cats',
          supportingText: 'One cat at a time. Find your favourites.',
        ),
        SizedBox(height: context.ui.space(6)),
        DiscoveryStage(discovery: discovery, actions: actions),
        SizedBox(height: context.ui.space(6)),
        Text(
          'Swipe left to dislike · Swipe right to like',
          textAlign: TextAlign.center,
          style: context.ui.text.textSm.copyWith(
            color: context.ui.colors.textTertiary,
          ),
        ),
      ],
    );
  }
}
