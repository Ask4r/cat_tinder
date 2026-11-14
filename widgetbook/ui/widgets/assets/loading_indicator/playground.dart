import 'package:cat_tinder/ui/widgets/assets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/catalog_theme.dart';

Widget buildLoadingIndicatorPlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final size = knobs.double.input(label: 'size', initialValue: 32);
  final customColor = knobs.boolean(label: 'color: override');
  final color = knobs.color(
    label: 'color',
    initialValue: const Color(0xFFEF6820),
  );
  final reducedMotion = knobs.boolean(label: 'Reduced motion');
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(
      disableAnimations:
          reducedMotion || MediaQuery.disableAnimationsOf(context),
    ),
    child: buildCatalogTheme(
      dark: dark,
      child: Center(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(32),
            child: size.isFinite && size >= 0
                ? LoadingIndicator(
                    size: size,
                    color: customColor ? color : null,
                  )
                : const Text('Enter a finite, non-negative size.'),
          ),
        ),
      ),
    ),
  );
}
