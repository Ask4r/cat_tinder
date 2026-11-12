import 'package:flutter/material.dart';

import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_button.dart';
import 'package:cat_tinder/ui/widgets/empty_state.dart';
import 'package:cat_tinder/ui/widgets/loading_state.dart';

import '../../layouts/application_layout.dart';

class DiscoveryLoading extends StatelessWidget {
  const DiscoveryLoading({super.key, this.compact = false});
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final variables = context.ui;
    final desktop =
        MediaQuery.sizeOf(context).width >= ApplicationLayout.desktopBreakpoint;
    return _DiscoveryStatusFrame(
      compact: compact,
      padding: compact
          ? EdgeInsets.zero
          : EdgeInsets.all(variables.space(desktop ? 8 : 6)),
      child: LoadingState(
        title: compact ? 'Loading photo' : 'Finding your next cat',
        message: 'This should only take a moment.',
      ),
    );
  }
}

class DiscoveryRecovery extends StatelessWidget {
  const DiscoveryRecovery({
    super.key,
    required this.message,
    required this.onRetry,
    this.onSkip,
  });
  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onSkip;

  @override
  Widget build(BuildContext context) {
    final desktop =
        MediaQuery.sizeOf(context).width >= ApplicationLayout.desktopBreakpoint;
    final photoFailed = onSkip != null;
    final variables = context.ui;
    final size = desktop ? AppButtonSize.md : AppButtonSize.sm;
    final content = EmptyState(
      size: desktop ? EmptyStateSize.md : EmptyStateSize.sm,
      title: photoFailed ? "Couldn't find this cat" : "Couldn't load this cat",
      message: message,
      icon: photoFailed ? 'search' : 'alert-circle',
      actions: [
        if (onSkip != null)
          AppButton(size: size, onPressed: onSkip, label: 'Skip photo'),
        Semantics(
          identifier: 'retry_button',
          child: AppButton(
            primary: true,
            size: size,
            onPressed: onRetry,
            label: 'Try again',
          ),
        ),
      ],
    );
    return _DiscoveryStatusFrame(
      compact: photoFailed,
      padding: EdgeInsets.all(
        variables.space(photoFailed ? (desktop ? 6 : 4) : (desktop ? 8 : 6)),
      ),
      child: content,
    );
  }
}

class _DiscoveryStatusFrame extends StatelessWidget {
  const _DiscoveryStatusFrame({
    required this.compact,
    required this.padding,
    required this.child,
  });

  final bool compact;
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final variables = context.ui;
    final desktop =
        MediaQuery.sizeOf(context).width >= ApplicationLayout.desktopBreakpoint;
    return Container(
      constraints: compact
          ? null
          : BoxConstraints(minHeight: desktop ? 534 : 458),
      decoration: BoxDecoration(
        color: compact
            ? variables.colors.bgSecondary
            : variables.colors.bgPrimary,
        borderRadius: compact
            ? null
            : BorderRadius.circular(variables.radii.xl),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.hasBoundedHeight
                  ? constraints.maxHeight
                  : constraints.minHeight,
            ),
            child: Padding(
              padding: padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
