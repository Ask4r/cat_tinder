import 'package:flutter/material.dart';

import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_button.dart';
import 'package:cat_tinder/ui/widgets/app_tooltip.dart';

import '../../layouts/application_layout.dart';

class DiscoveryCardFooter extends StatelessWidget {
  const DiscoveryCardFooter({
    super.key,
    required this.breedName,
    required this.enabled,
    required this.onDecision,
  });

  final String breedName;
  final bool enabled;
  final ValueChanged<bool> onDecision;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(
      MediaQuery.sizeOf(context).width >= ApplicationLayout.desktopBreakpoint
          ? context.ui.space(6)
          : context.ui.space(4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          identifier: 'cat_breed_name',
          child: Text(
            breedName,
            style: context.ui.text.displayXs.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: context.ui.space(1)),
        Align(
          alignment: Alignment.centerLeft,
          child: AppTooltip(
            message: 'Breed details are not available yet.',
            child: AppButton(
              hierarchy: AppButtonHierarchy.linkColor,
              size: AppButtonSize.sm,
              onPressed: null,
              label: 'View breed details',
            ),
          ),
        ),
        SizedBox(height: context.ui.space(5)),
        LayoutBuilder(
          builder: (context, constraints) {
            final buttons = [
              Semantics(
                identifier: 'dislike_button',
                child: AppButton(
                  hierarchy: AppButtonHierarchy.secondary,
                  onPressed: enabled ? () => onDecision(false) : null,
                  icon: 'close',
                  label: 'Dislike',
                ),
              ),
              Semantics(
                identifier: 'like_button',
                child: AppButton(
                  hierarchy: AppButtonHierarchy.primary,
                  onPressed: enabled ? () => onDecision(true) : null,
                  icon: 'heart',
                  label: 'Like',
                ),
              ),
            ];
            if (MediaQuery.textScalerOf(context).scale(16) > 24 ||
                constraints.maxWidth < 260) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buttons[0],
                  SizedBox(height: context.ui.space(3)),
                  buttons[1],
                ],
              );
            }
            return Row(
              children: [
                Expanded(child: buttons[0]),
                SizedBox(width: context.ui.space(3)),
                Expanded(child: buttons[1]),
              ],
            );
          },
        ),
      ],
    ),
  );
}
