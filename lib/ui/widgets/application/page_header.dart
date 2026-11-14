import 'package:flutter/material.dart';

import '../../theme.dart';

/// Figma's Simple page header. Desktop and mobile share the same recipe.
class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.supportingText,
    this.actions = const [],
  });

  final String title;
  final String supportingText;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: v.space(.5),
      children: [
        Text(title, style: v.text.textXl.copyWith(fontWeight: FontWeight.w600)),
        Text(
          supportingText,
          style: v.text.textMd.copyWith(color: v.colors.textTertiary),
        ),
      ],
    );
    if (actions.isEmpty) return text;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: v.space(4),
      children: [
        Expanded(child: text),
        Wrap(spacing: v.space(3), runSpacing: v.space(3), children: actions),
      ],
    );
  }
}
