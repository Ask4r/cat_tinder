import 'package:flutter/material.dart';

import 'package:cat_tinder/state/discovery.dart';

import 'discovery_card.dart';
import 'discovery_status.dart';

/// Presents the current encounter or recovery state and owns their transitions.
class DiscoveryStage extends StatelessWidget {
  const DiscoveryStage({
    super.key,
    required this.discovery,
    required this.actions,
  });

  final DiscoveryState discovery;
  final Discovery actions;

  @override
  Widget build(BuildContext context) {
    final current = discovery.current;
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 480),
        child: AnimatedSwitcher(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 260),
          reverseDuration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 340),
          switchInCurve: Curves.easeOut,
          layoutBuilder: (current, previous) => Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [?current, ...previous],
          ),
          transitionBuilder: (child, animation) => AnimatedBuilder(
            animation: animation,
            builder: (context, _) {
              final outgoing =
                  animation.status == AnimationStatus.reverse ||
                  animation.status == AnimationStatus.dismissed;
              return IgnorePointer(
                ignoring: outgoing,
                child: ExcludeSemantics(
                  excluding: outgoing,
                  child: Opacity(
                    opacity: outgoing && child is DiscoveryCard
                        ? 1
                        : animation.value,
                    child: child,
                  ),
                ),
              );
            },
          ),
          child: current != null
              ? DiscoveryCard(
                  key: ValueKey(current.number),
                  encounter: current,
                  onDecision: (liked) => actions.decide(current.number, liked),
                  onRetry: () => actions.retryPhotograph(current.number),
                  onSkip: () => actions.skip(current.number),
                  onReady: () => actions.photographLoaded(current.number),
                  onDecodeFailure: () =>
                      actions.photographFailed(current.number),
                )
              : discovery.error != null
              ? DiscoveryRecovery(
                  message: discovery.error!,
                  onRetry: actions.refill,
                )
              : DiscoveryLoading(),
        ),
      ),
    );
  }
}
