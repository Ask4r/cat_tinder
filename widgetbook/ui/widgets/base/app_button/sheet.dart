import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/base/app_button.dart';

import 'package:flutter/material.dart';

const _iconButtonHierarchies = [
  AppButtonHierarchy.primary,
  AppButtonHierarchy.secondary,
  AppButtonHierarchy.tertiary,
];

enum ButtonExample {
  defaultState,
  leadingIcon,
  trailingIcon,
  disabled,
  loading,
}

String buttonCellId(
  AppButtonHierarchy hierarchy,
  AppButtonSize size,
  ButtonExample example,
) => '${hierarchy.name}-${size.name}-${example.name}';

/// Shared by the interactive catalog and screenshot runner; no copied recipes.
class ButtonSheet extends StatelessWidget {
  const ButtonSheet({super.key, this.iconButtons = false});

  final bool iconButtons;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(220),
        children: [
          for (final hierarchy
              in iconButtons
                  ? _iconButtonHierarchies
                  : AppButtonHierarchy.values)
            for (final size in AppButtonSize.values)
              TableRow(
                children: [
                  for (final example
                      in iconButtons
                          ? [
                              ButtonExample.defaultState,
                              ButtonExample.disabled,
                              ButtonExample.loading,
                            ]
                          : ButtonExample.values)
                    RepaintBoundary(
                      key: ValueKey(buttonCellId(hierarchy, size, example)),
                      child: ColoredBox(
                        color: context.ui.colors.bgPrimary,
                        child: SizedBox(
                          height: 132,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${hierarchy.name} / ${size.name}\n${example.name}',
                                  style: context.ui.text.textXs.copyWith(
                                    color: context.ui.colors.textTertiary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                if (iconButtons)
                                  AppButton(
                                    iconOnly: true,
                                    icon: 'placeholder',
                                    label: 'Button',
                                    size: size,
                                    hierarchy: hierarchy,
                                    loading: example == ButtonExample.loading,
                                    onPressed: example == ButtonExample.disabled
                                        ? null
                                        : () {},
                                  )
                                else
                                  AppButton(
                                    label: 'Button',
                                    size: size,
                                    hierarchy: hierarchy,
                                    icon: example == ButtonExample.leadingIcon
                                        ? 'placeholder'
                                        : null,
                                    trailingIcon:
                                        example == ButtonExample.trailingIcon
                                        ? 'placeholder'
                                        : null,
                                    loading: example == ButtonExample.loading,
                                    onPressed: example == ButtonExample.disabled
                                        ? null
                                        : () {},
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
        ],
      ),
    ),
  );
}
