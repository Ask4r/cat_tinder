import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/base/app_button.dart';
import 'package:cat_tinder/ui/widgets/application/empty_state.dart';
import 'package:flutter/material.dart';

import '../../../../internal/constrained_preview.dart';

const emptyStateTitle = 'No results found';
const emptyStateMessage =
    'Try changing your search or come back later to explore more.';

List<Widget> emptyStateActions({
  required int count,
  required EmptyStateSize size,
  String primaryLabel = 'Try again',
  String secondaryLabel = 'Go back',
  bool enabled = true,
}) => [
  if (count > 1)
    AppButton(
      label: secondaryLabel,
      hierarchy: AppButtonHierarchy.secondary,
      size: size == EmptyStateSize.sm ? AppButtonSize.sm : AppButtonSize.md,
      onPressed: enabled ? () {} : null,
    ),
  if (count > 0)
    AppButton(
      label: primaryLabel,
      size: size == EmptyStateSize.sm ? AppButtonSize.sm : AppButtonSize.md,
      onPressed: enabled ? () {} : null,
    ),
];

/// Shared composition examples, using the production EmptyState and actions.
class EmptyStateSheet extends StatelessWidget {
  const EmptyStateSheet({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(400),
        children: [
          for (final row in [
            [
              for (final size in EmptyStateSize.values)
                (
                  size: size,
                  label: 'No actions',
                  count: 0,
                  width: 368.0,
                  primaryLabel: 'Try again',
                ),
            ],
            const [
              (
                size: EmptyStateSize.md,
                label: 'One action',
                count: 1,
                width: 368.0,
                primaryLabel: 'Try again',
              ),
              (
                size: EmptyStateSize.sm,
                label: 'Two actions',
                count: 2,
                width: 368.0,
                primaryLabel: 'Try again',
              ),
              (
                size: EmptyStateSize.lg,
                label: 'Narrow / wrapping',
                count: 2,
                width: 200.0,
                primaryLabel: 'Try another search',
              ),
            ],
          ])
            TableRow(
              children: [
                for (final example in row)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${example.size.name} / ${example.label}',
                          style: context.ui.text.textXs.copyWith(
                            color: context.ui.colors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: example.width,
                          child: ConstrainedPreview(
                            child: EmptyState(
                              title: emptyStateTitle,
                              message: emptyStateMessage,
                              icon: 'placeholder',
                              size: example.size,
                              actions: emptyStateActions(
                                count: example.count,
                                size: example.size,
                                primaryLabel: example.primaryLabel,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    ),
  );
}
