import 'package:cat_tinder/ui/widgets/application/loading_state.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'sheet.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildLoadingStatePlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final title = knobs.string(label: 'title', initialValue: loadingStateTitle);
  final message = knobs.string(
    label: 'message',
    initialValue: loadingStateMessage,
  );
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
            child: LoadingState(title: title, message: message),
          ),
        ),
      ),
    ),
  );
}
