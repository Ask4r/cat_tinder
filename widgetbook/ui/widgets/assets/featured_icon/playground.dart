import 'package:cat_tinder/ui/widgets/assets/featured_icon.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/catalog_icons.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildFeaturedIconPlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final icon = knobs.object.dropdown(
    label: 'icon',
    options: catalogIcons,
    initialOption: 'placeholder',
  );
  final size = knobs.object.dropdown(
    label: 'size',
    options: FeaturedIconSize.values,
    initialOption: FeaturedIconSize.lg,
    labelBuilder: (value) => value.name,
  );
  final color = knobs.object.dropdown(
    label: 'color',
    options: FeaturedIconColor.values,
    initialOption: FeaturedIconColor.gray,
    labelBuilder: (value) => value.name,
  );
  final style = knobs.object.dropdown(
    label: 'style',
    options: FeaturedIconStyle.values,
    initialOption: FeaturedIconStyle.modern,
    labelBuilder: (value) => value.name,
  );
  final invalid =
      style == FeaturedIconStyle.modern && color != FeaturedIconColor.gray;
  return buildCatalogTheme(
    dark: dark,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: invalid
            ? const Text('Modern featured icons support only the gray color.')
            : FeaturedIcon(icon, size: size, color: color, style: style),
      ),
    ),
  );
}
