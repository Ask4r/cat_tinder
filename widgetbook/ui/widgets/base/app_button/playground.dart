import 'package:cat_tinder/ui/widgets/base/app_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/focus_preview.dart';
import '../../../../internal/catalog_icons.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildButtonPlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final label = knobs.string(label: 'label', initialValue: 'Button');
  final size = knobs.object.dropdown(
    label: 'size',
    options: AppButtonSize.values,
    initialOption: AppButtonSize.xl,
    labelBuilder: (value) => value.name,
  );
  final hierarchy = knobs.object.dropdown(
    label: 'hierarchy',
    options: AppButtonHierarchy.values,
    initialOption: AppButtonHierarchy.primary,
    labelBuilder: (value) => value.name,
  );
  final icon = knobs.objectOrNull.dropdown(
    label: 'icon',
    options: catalogIcons,
    initialOption: 'placeholder',
    defaultToNull: true,
  );
  final trailingIcon = knobs.objectOrNull.dropdown(
    label: 'trailingIcon',
    options: catalogIcons,
    initialOption: 'placeholder',
    defaultToNull: true,
  );
  final iconOnly = knobs.boolean(
    label: 'iconOnly',
    description: 'Requires icon; link hierarchies are not supported.',
  );
  final loading = knobs.boolean(label: 'loading');
  final loadingLabel = knobs.string(
    label: 'loadingLabel',
    initialValue: 'Submitting...',
  );
  final enabled = knobs.boolean(
    label: 'onPressed enabled',
    initialValue: true,
    description: 'Off supplies null; on supplies a no-op callback. Loading disables activation.',
  );
  final invalidIconOnly =
      iconOnly &&
      (icon == null ||
          hierarchy == AppButtonHierarchy.linkColor ||
          hierarchy == AppButtonHierarchy.linkGray);

  return buildCatalogTheme(
    dark: dark,
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: FocusPreview(
          canFocus: enabled && !loading && !invalidIconOnly,
          child: invalidIconOnly
              ? const Text(
                  'Icon-only buttons require an icon and a non-link hierarchy.',
                )
              : AppButton(
                  label: label,
                  size: size,
                  hierarchy: hierarchy,
                  icon: icon,
                  trailingIcon: trailingIcon,
                  iconOnly: iconOnly,
                  loading: loading,
                  loadingLabel: loadingLabel,
                  onPressed: enabled ? () {} : null,
                ),
        ),
      ),
    ),
  );
}
