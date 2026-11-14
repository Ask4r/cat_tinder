import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../theme.dart';
import '../base/app_tooltip.dart';
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
    this.tooltipViewportPadding = EdgeInsets.zero,
    this.tooltipViewportMaxWidth = double.infinity,
  });

  final List<TabItem<T>> items;
  final T value;
  final ValueChanged<T>? onChanged;
  final HorizontalTabsStyle style;
  final TabSize size;
  final bool fullWidth;
  final TabsBreakpoint breakpoint;
  final EdgeInsets tooltipViewportPadding;
  final double tooltipViewportMaxWidth;

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
                tab = AppTooltip(
                  message: item.tooltip!,
                  viewportPadding: tooltipViewportPadding,
                  viewportMaxWidth: tooltipViewportMaxWidth,
                  child: tab,
                );
              }
              if (item.semanticIdentifier != null) {
                tab = Semantics(
                  identifier: item.semanticIdentifier,
                  child: tab,
                );
              }
              children.add(expand ? Expanded(child: tab) : tab);
            }
            final mainAxisSize = expand ? MainAxisSize.max : MainAxisSize.min;
            final row = minimal
                ? _MinimalTabsRow(
                    selectedChildIndex: items.indexWhere(
                      (item) => item.value == value,
                    ),
                    mainAxisSize: mainAxisSize,
                    spacing: gap,
                    children: children,
                  )
                : Row(
                    mainAxisSize: mainAxisSize,
                    spacing: gap,
                    children: children,
                  );
            return expand
                ? row
                : SingleChildScrollView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    child: Builder(
                      builder: (context) => ClipRect(
                        clipper: _TabViewportClipper(
                          Scrollable.of(context).position,
                          decorationOutset: _tabDecorationOutset(
                            style,
                            v.effects,
                          ),
                        ),
                        child: row,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}

// Minimal tabs have only a 2px gap. Paint the opaque selected surface first
// so it cannot cover a neighbor's outside focus ring. Native Flex still owns
// layout, hit testing, semantics and overflow handling.
class _MinimalTabsRow extends Row {
  const _MinimalTabsRow({
    required this.selectedChildIndex,
    required super.mainAxisSize,
    required super.spacing,
    required super.children,
  });

  final int selectedChildIndex;

  @override
  _RenderMinimalTabsRow createRenderObject(BuildContext context) =>
      _RenderMinimalTabsRow(
        selectedChildIndex,
        mainAxisSize: mainAxisSize,
        spacing: spacing,
        textDirection: Directionality.of(context),
      );

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _RenderMinimalTabsRow renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
    renderObject.selectedChildIndex = selectedChildIndex;
  }
}

class _RenderMinimalTabsRow extends RenderFlex {
  _RenderMinimalTabsRow(
    this._selectedChildIndex, {
    required super.mainAxisSize,
    required super.spacing,
    required super.textDirection,
  }) : super(direction: Axis.horizontal);

  int _selectedChildIndex;
  set selectedChildIndex(int value) {
    if (_selectedChildIndex == value) return;
    _selectedChildIndex = value;
    markNeedsPaint();
  }

  @override
  void defaultPaint(PaintingContext context, Offset offset) {
    RenderBox? selected;
    var child = firstChild;
    for (var index = 0; child != null; index++) {
      if (index == _selectedChildIndex) {
        selected = child;
        final data = child.parentData! as FlexParentData;
        context.paintChild(child, offset + data.offset);
        break;
      }
      child = childAfter(child);
    }
    child = firstChild;
    while (child != null) {
      final data = child.parentData! as FlexParentData;
      if (child != selected) context.paintChild(child, offset + data.offset);
      child = childAfter(child);
    }
  }
}

double _tabDecorationOutset(HorizontalTabsStyle style, UiEffects effects) {
  if (style == HorizontalTabsStyle.underline) return 0;
  return [
    if (style == HorizontalTabsStyle.minimal) effects.shadowXs,
    if (style == HorizontalTabsStyle.border) ...effects.shadowSm,
  ].fold<double>(
    4,
    (outset, shadow) => math.max(
      outset,
      shadow.blurSigma * 3 +
          shadow.spreadRadius +
          math.max(shadow.offset.dx.abs(), shadow.offset.dy.abs()),
    ),
  );
}

// Paint-only clearance: no padding, extra scroll extent or scroll controller.
// At a scrolled edge content stays clipped; at a content end decorations can
// extend past the viewport. The 4px minimum matches TabButton's focus outline.
class _TabViewportClipper extends CustomClipper<Rect> {
  _TabViewportClipper(this.position, {required this.decorationOutset})
    : super(reclip: position);

  final ScrollPosition position;
  final double decorationOutset;

  @override
  Rect getClip(Size size) {
    if (!position.hasContentDimensions) {
      return (Offset.zero & size).inflate(decorationOutset);
    }
    final reversed = position.axisDirection == AxisDirection.left;
    final start = reversed
        ? size.width - position.viewportDimension - position.pixels
        : position.pixels;
    final end = start + position.viewportDimension;
    return Rect.fromLTRB(
      start <= 0 ? -decorationOutset : start,
      -decorationOutset,
      end >= size.width ? size.width + decorationOutset : end,
      size.height + decorationOutset,
    );
  }

  @override
  Rect getApproximateClipRect(Size size) => getClip(size);

  @override
  // Viewport dimensions can change without notifying scroll listeners.
  bool shouldReclip(_TabViewportClipper oldClipper) => true;
}
