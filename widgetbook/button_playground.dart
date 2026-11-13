import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'focus_preview.dart';

const _icons = [
  'placeholder',
  'alert-circle',
  'chevron-down',
  'close',
  'heart',
  'loading',
  'paw',
  'search',
];

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
    options: _icons,
    initialOption: 'placeholder',
    defaultToNull: true,
  );
  final trailingIcon = knobs.objectOrNull.dropdown(
    label: 'trailingIcon',
    options: _icons,
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

  return Theme(
    data: appTheme(
      variables: UiVariables(colors: UiColors(dark: dark)),
    ),
    child: Material(
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
    ),
  );
}
