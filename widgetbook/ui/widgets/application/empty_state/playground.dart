import 'package:cat_tinder/ui/widgets/application/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/constrained_preview.dart';

import '../../../../internal/catalog_icons.dart';
import 'sheet.dart';
import '../../../../internal/focus_preview.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildEmptyStatePlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final title = knobs.string(label: 'title', initialValue: emptyStateTitle);
  final message = knobs.string(
    label: 'message',
    initialValue: emptyStateMessage,
  );
  final icon = knobs.object.dropdown(
    label: 'icon',
    options: catalogIcons,
    initialOption: 'placeholder',
  );
  final size = knobs.object.dropdown(
    label: 'size',
    options: EmptyStateSize.values,
    initialOption: EmptyStateSize.md,
    labelBuilder: (value) => value.name,
  );
  final count = knobs.object.dropdown(
    label: 'actions',
    options: [0, 1, 2],
    initialOption: 0,
    labelBuilder: (value) => '$value actions',
    description: 'Example widgets supplied to the actions slot; not an EmptyState restriction.',
  );
  final primaryLabel = knobs.string(
    label: 'actions: primary label',
    initialValue: 'Try again',
  );
  final secondaryLabel = knobs.string(
    label: 'actions: secondary label',
    initialValue: 'Go back',
  );
  final enabled = knobs.boolean(label: 'actions: enabled', initialValue: true);
  final width = knobs.double.slider(
    label: 'Preview width',
    min: 200,
    max: 600,
    initialValue: 400,
    description: 'Host constraint, not an EmptyState property.',
  );
  return buildCatalogTheme(
    dark: dark,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: FocusPreview(
          canFocus: enabled && count > 0,
          child: SizedBox(
            width: width,
            child: ConstrainedPreview(
              child: EmptyState(
                title: title,
                message: message,
                icon: icon,
                size: size,
                actions: emptyStateActions(
                  count: count,
                  size: size,
                  primaryLabel: primaryLabel,
                  secondaryLabel: secondaryLabel,
                  enabled: enabled,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
