import 'package:cat_tinder/ui/widgets/base/app_button.dart';
import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';
import 'package:cat_tinder/ui/widgets/base/app_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'sheet.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildTooltipPlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final message = knobs.string(label: 'message', initialValue: tooltipMessage);
  final hasSupporting = knobs.boolean(label: 'supportingText: enabled');
  final supporting = knobs.string(
    label: 'supportingText',
    initialValue: tooltipSupportingText,
  );
  final arrow = knobs.object.dropdown(
    label: 'arrow',
    options: TooltipArrow.values,
    initialOption: TooltipArrow.topCenter,
    labelBuilder: (value) => value.name,
  );
  double viewportInset(String edge) => knobs.double.slider(
    label: 'viewportPadding.$edge',
    initialValue: 0,
    min: 0,
    max: 128,
    description:
        'Inset from the overlay boundary, separate from content padding.',
  );
  final viewportPadding = EdgeInsets.fromLTRB(
    viewportInset('left'),
    viewportInset('top'),
    viewportInset('right'),
    viewportInset('bottom'),
  );
  final unlimitedViewport = knobs.boolean(
    label: 'viewportMaxWidth: unlimited',
    initialValue: true,
  );
  final viewportWidth = knobs.double.slider(
    label: 'viewportMaxWidth',
    initialValue: 1280,
    min: 1,
    max: 1920,
    description:
        'Centered boundary width before padding; used when unlimited is off.',
  );
  final childKind = knobs.object.dropdown(
    label: 'child',
    options: ['Text', 'Button', 'Icon'],
    initialOption: 'Text',
    description: 'Sample widgets for the arbitrary child slot.',
  );
  final childLabel = knobs.string(
    label: 'child: label',
    initialValue: 'Hover / hold',
  );
  final alignment = knobs.object.dropdown(
    label: 'Target position',
    options: [
      Alignment.center,
      Alignment.topLeft,
      Alignment.topRight,
      Alignment.bottomLeft,
      Alignment.bottomRight,
    ],
    initialOption: Alignment.center,
    description: 'Host placement for testing collision handling.',
    labelBuilder: (value) => value.toString(),
  );
  return buildCatalogTheme(
    dark: dark,
    child: TooltipViewport(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Align(
          alignment: alignment,
          child: AppTooltip(
            message: message,
            supportingText: hasSupporting ? supporting : null,
            arrow: arrow,
            viewportPadding: viewportPadding,
            viewportMaxWidth: unlimitedViewport
                ? double.infinity
                : viewportWidth,
            child: switch (childKind) {
              'Button' => AppButton(
                label: childLabel,
                size: AppButtonSize.md,
                onPressed: () {},
              ),
              'Icon' => const Padding(
                padding: EdgeInsets.all(8),
                child: AppIcon('placeholder'),
              ),
              _ => Padding(
                padding: const EdgeInsets.all(8),
                child: Text(childLabel),
              ),
            },
          ),
        ),
      ),
    ),
  );
}
