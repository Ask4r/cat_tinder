import 'package:flutter/material.dart';

import '../theme.dart';
import 'featured_icon.dart';

enum EmptyStateSize { sm, md, lg }

/// A status message with a featured icon and an optional set of actions.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    required this.icon,
    this.size = EmptyStateSize.md,
    this.actions = const [],
  });

  final String title;
  final String message;
  final String icon;
  final EmptyStateSize size;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final variables = context.ui;
    final compact = size == EmptyStateSize.sm;
    final large = size == EmptyStateSize.lg;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FeaturedIcon(
          icon,
          size: large ? FeaturedIconSize.xl : FeaturedIconSize.lg,
        ),
        SizedBox(height: variables.space(compact ? 4 : 5)),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 352),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    (large
                            ? variables.text.textXl
                            : compact
                            ? variables.text.textMd
                            : variables.text.textLg)
                        .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: variables.space(compact ? 1 : 2)),
              Text(
                message,
                textAlign: TextAlign.center,
                style: (large ? variables.text.textMd : variables.text.textSm)
                    .copyWith(color: variables.colors.textTertiary),
              ),
            ],
          ),
        ),
        if (actions.isNotEmpty) ...[
          SizedBox(height: variables.space(compact ? 6 : 8)),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: variables.space(3),
            runSpacing: variables.space(3),
            children: actions,
          ),
        ],
      ],
    );
  }
}
