import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/catalog_icons.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildAppIconPlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final name = knobs.object.dropdown(
    label: 'name',
    options: catalogIcons,
    initialOption: 'placeholder',
  );
  final size = knobs.double.input(label: 'size', initialValue: 20);
  final customColor = knobs.boolean(label: 'color: override');
  final color = knobs.color(
    label: 'color',
    initialValue: const Color(0xFFEF6820),
  );
  return buildCatalogTheme(
    dark: dark,
    child: Center(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(32),
          child: size.isFinite && size >= 0
              ? AppIcon(name, size: size, color: customColor ? color : null)
              : const Text('Enter a finite, non-negative size.'),
        ),
      ),
    ),
  );
}
