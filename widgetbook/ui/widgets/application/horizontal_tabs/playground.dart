import 'package:cat_tinder/ui/widgets/assets/app_icon.dart';
import 'package:cat_tinder/ui/widgets/application/horizontal_tabs.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import '../../../../internal/catalog_icons.dart';
import '../../../../internal/focus_preview.dart';
import 'examples.dart';
import '../../../../internal/catalog_theme.dart';

Widget buildHorizontalTabsPlayground(BuildContext context) {
  final knobs = context.knobs;
  final dark = knobs.boolean(label: 'Dark theme');
  final style = knobs.object.dropdown(
    label: 'style',
    options: HorizontalTabsStyle.values,
    initialOption: HorizontalTabsStyle.underline,
    labelBuilder: (v) => v.name,
  );
  final size = knobs.object.dropdown(
    label: 'size',
    options: TabSize.values,
    initialOption: TabSize.sm,
    labelBuilder: (v) => v.name,
  );
  final fullWidth = knobs.boolean(label: 'fullWidth');
  final enabled = knobs.boolean(label: 'onChanged enabled', initialValue: true);
  final count = knobs.object.dropdown(
    label: 'items: count',
    options: [1, 2, 3, 4],
    initialOption: 3,
    description: 'Catalog sample count; the widget accepts any list.',
  );
  final items = <TabItem<String>>[];
  for (var i = 0; i < count; i++) {
    final prefix = 'items[$i]';
    final value = knobs.string(label: '$prefix.value', initialValue: 'item-$i');
    final label = knobs.string(
      label: '$prefix.label',
      initialValue: ['Overview', 'Details', 'Activity', 'Settings'][i],
    );
    final itemEnabled = knobs.boolean(
      label: '$prefix.enabled',
      initialValue: true,
    );
    final leading = knobs.boolean(label: '$prefix.leading: enabled');
    final icon = knobs.object.dropdown(
      label: '$prefix.leading: icon',
      options: catalogIcons,
      initialOption: 'placeholder',
    );
    final badge = knobs.boolean(label: '$prefix.badge: enabled');
    final badgeText = knobs.string(
      label: '$prefix.badge: text',
      initialValue: '${i + 2}',
    );
    final tooltip = knobs.boolean(label: '$prefix.tooltip: enabled');
    final tooltipText = knobs.string(
      label: '$prefix.tooltip',
      initialValue:
          'More about ${['Overview', 'Details', 'Activity', 'Settings'][i]}.',
    );
    final identified = knobs.boolean(
      label: '$prefix.semanticIdentifier: enabled',
    );
    final identifier = knobs.string(
      label: '$prefix.semanticIdentifier',
      initialValue: 'catalog-item-$i',
    );
    items.add(
      TabItem(
        value: value,
        label: label,
        enabled: itemEnabled,
        leading: leading ? AppIcon(icon) : null,
        badge: badge ? CatalogTabBadge(badgeText) : null,
        tooltip: tooltip ? tooltipText : null,
        semanticIdentifier: identified ? identifier : null,
      ),
    );
  }
  final selectedIndex = knobs.object.dropdown(
    label: 'value',
    options: List.generate(count, (i) => i),
    initialOption: 0,
    labelBuilder: (i) => items[i].value,
    description: 'Starting controlled value. Clicking tabs updates the preview; changing this knob resets selection.',
  );
  double inset(String edge) => knobs.double.slider(
    label: 'tooltipViewportPadding.$edge',
    initialValue: 0,
    min: 0,
    max: 128,
  );
  final tooltipPadding = EdgeInsets.fromLTRB(
    inset('left'),
    inset('top'),
    inset('right'),
    inset('bottom'),
  );
  final unlimited = knobs.boolean(
    label: 'tooltipViewportMaxWidth: unlimited',
    initialValue: true,
  );
  final tooltipMaxWidth = knobs.double.slider(
    label: 'tooltipViewportMaxWidth',
    initialValue: 1280,
    min: 1,
    max: 1920,
  );
  final width = knobs.double.slider(
    label: 'Preview width',
    initialValue: 640,
    min: 200,
    max: 1000,
    description:
        'Host constraint for full-width and horizontal-overflow examples.',
  );
  final valid = items.map((item) => item.value).toSet().length == items.length;
  return buildCatalogTheme(
    dark: dark,
    child: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: valid
              ? _TabsPreview(
                  items: items,
                  initialValue: items[selectedIndex].value,
                  style: style,
                  size: size,
                  fullWidth: fullWidth,
                  enabled: enabled,
                  width: width,
                  tooltipPadding: tooltipPadding,
                  tooltipMaxWidth: unlimited
                      ? double.infinity
                      : tooltipMaxWidth,
                )
              : const Text(
                  'Give each item a unique value before rendering the preview.',
                ),
        ),
      ),
    ),
  );
}

class _TabsPreview extends StatefulWidget {
  const _TabsPreview({
    required this.items,
    required this.initialValue,
    required this.style,
    required this.size,
    required this.fullWidth,
    required this.enabled,
    required this.width,
    required this.tooltipPadding,
    required this.tooltipMaxWidth,
  });
  final List<TabItem<String>> items;
  final String initialValue;
  final HorizontalTabsStyle style;
  final TabSize size;
  final bool fullWidth, enabled;
  final double width, tooltipMaxWidth;
  final EdgeInsets tooltipPadding;
  @override
  State<_TabsPreview> createState() => _TabsPreviewState();
}

class _TabsPreviewState extends State<_TabsPreview> {
  late String value = widget.initialValue;
  @override
  void didUpdateWidget(_TabsPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue ||
        !widget.items.any((item) => item.value == value)) {
      value = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: widget.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Current value: $value'),
        const SizedBox(height: 16),
        FocusPreview(
          canFocus: widget.enabled && widget.items.any((item) => item.enabled),
          child: SizedBox(
            height: 240,
            child: Overlay.wrap(
              child: Center(
                child: HorizontalTabs<String>(
                  items: widget.items,
                  value: value,
                  onChanged: widget.enabled
                      ? (next) => setState(() => value = next)
                      : null,
                  style: widget.style,
                  size: widget.size,
                  fullWidth: widget.fullWidth,
                  tooltipViewportPadding: widget.tooltipPadding,
                  tooltipViewportMaxWidth: widget.tooltipMaxWidth,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
