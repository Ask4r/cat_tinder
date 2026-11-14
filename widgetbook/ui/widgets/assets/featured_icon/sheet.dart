import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/assets/featured_icon.dart';
import 'package:flutter/material.dart';

/// All supported style/color combinations, with sizes side by side.
class FeaturedIconSheet extends StatelessWidget {
  const FeaturedIconSheet({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: context.ui.colors.bgPrimary,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Table(
        defaultColumnWidth: const FixedColumnWidth(200),
        children: [
          for (final style in FeaturedIconStyle.values)
            for (final color
                in style == FeaturedIconStyle.modern
                    ? [FeaturedIconColor.gray]
                    : FeaturedIconColor.values)
              TableRow(
                children: [
                  for (final size in FeaturedIconSize.values)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${style.name} / ${color.name} / ${size.name}',
                            style: context.ui.text.textXs.copyWith(
                              color: context.ui.colors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FeaturedIcon(
                            'placeholder',
                            size: size,
                            color: color,
                            style: style,
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
