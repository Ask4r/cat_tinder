import 'package:cat_tinder/ui/widgets/application/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/catalog_theme.dart';

Widget buildLoadingStatePlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final style = knobs.object.dropdown(
    label: 'style',
    options: LoadingStateStyle.values,
    initialOption: LoadingStateStyle.lineSimple,
    labelBuilder: (value) => value.name,
  );
  final size = knobs.object.dropdown(
    label: 'size',
    options: LoadingStateSize.values,
    initialOption: LoadingStateSize.sm,
    labelBuilder: (value) => value.name,
  );
  final showText = knobs.boolean(label: 'text: enabled', initialValue: true);
  final text = knobs.string(label: 'text', initialValue: 'Loading...');
  final width = knobs.double.slider(
    label: 'Preview width',
    initialValue: 400,
    min: 200,
    max: 600,
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
          padding: const EdgeInsets.all(32),
          child: SizedBox(
            width: width,
            child: LoadingState(
              style: style,
              size: size,
              text: showText ? text : null,
            ),
          ),
        ),
      ),
    ),
  );
}
