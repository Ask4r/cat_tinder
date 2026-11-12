import 'package:flutter/material.dart';

import '../theme.dart';
import 'app_tooltip.dart';
import 'tab_button.dart';
import 'tab_item.dart';
import 'tabs_select.dart';

export 'tab_button.dart' show TabSize;
export 'tab_item.dart' show TabItem;
export 'tabs_select.dart' show TabsSelect;

enum HorizontalTabsStyle { underline, minimal, border, gray, brand }

enum TabsBreakpoint { desktop, mobile }

/// The parent chooses the breakpoint variant; mobile renders the Figma select.
class HorizontalTabs<T> extends StatelessWidget {
  const HorizontalTabs({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.style = HorizontalTabsStyle.underline,
    this.size = TabSize.sm,
    this.fullWidth = false,
    this.breakpoint = TabsBreakpoint.desktop,
  });

  final List<TabItem<T>> items;
  final T value;
  final ValueChanged<T>? onChanged;
  final HorizontalTabsStyle style;
  final TabSize size;
  final bool fullWidth;
  final TabsBreakpoint breakpoint;

  @override
  Widget build(BuildContext context) {
    if (breakpoint == TabsBreakpoint.mobile) {
      return TabsSelect(
        items: items,
        value: value,
        onChanged: onChanged,
        size: size,
      );
    }
    final v = context.ui;
    final underline = style == HorizontalTabsStyle.underline;
    final minimal = style == HorizontalTabsStyle.minimal;
    final border = style == HorizontalTabsStyle.border;
    final buttonStyle = switch (style) {
      HorizontalTabsStyle.underline => TabButtonStyle.underline,
      HorizontalTabsStyle.minimal => TabButtonStyle.minimal,
      HorizontalTabsStyle.border => TabButtonStyle.white,
      HorizontalTabsStyle.gray => TabButtonStyle.gray,
      HorizontalTabsStyle.brand => TabButtonStyle.brand,
    };
    final gap = v.space(
      underline
          ? 3
          : minimal
          ? .5
          : 1,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        border: underline
            ? Border(bottom: BorderSide(color: v.colors.borderSecondary))
            : null,
      ),
      child: Container(
        padding: border
            ? EdgeInsets.all(v.space(1))
            : underline && (fullWidth || size == TabSize.md)
            ? const EdgeInsets.only(bottom: 1)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: minimal || border ? v.colors.bgSecondaryAlt : null,
          borderRadius: underline ? null : BorderRadius.circular(v.radii.md),
          border: minimal || border
              ? Border.all(color: v.colors.borderSecondary)
              : null,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final expand = fullWidth && constraints.hasBoundedWidth;
            final children = <Widget>[];
            for (final item in items) {
              if (children.isNotEmpty) children.add(SizedBox(width: gap));
              Widget tab = TabButton(
                key: ValueKey(item.value),
                label: item.label,
                selected: item.value == value,
                style: buttonStyle,
                size: size,
                leading: item.leading,
                badge: item.badge,
                onPressed: item.enabled && onChanged != null
                    ? () {
                        if (item.value != value) onChanged!(item.value);
                      }
                    : null,
              );
              if (item.tooltip != null) {
                tab = AppTooltip(message: item.tooltip!, child: tab);
              }
              if (item.semanticIdentifier != null) {
                tab = Semantics(
                  identifier: item.semanticIdentifier,
                  child: tab,
                );
              }
              children.add(expand ? Expanded(child: tab) : tab);
            }
            final row = Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              children: children,
            );
            return expand
                ? row
                : SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: row,
                  );
          },
        ),
      ),
    );
  }
}
