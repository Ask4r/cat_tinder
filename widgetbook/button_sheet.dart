import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

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
  const ButtonSheet({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(220),
        children: [
          for (final hierarchy in AppButtonHierarchy.values)
            for (final size in AppButtonSize.values)
              TableRow(
                children: [
                  for (final example in ButtonExample.values)
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
