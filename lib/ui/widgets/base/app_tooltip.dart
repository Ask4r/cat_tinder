import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';

import '../../theme.dart';

enum TooltipArrow {
  none,
  topCenter,
  bottomCenter,
  bottomLeft,
  bottomRight,
  left,
  right,
}

/// Native synchronous overlay layout with Forui slide and target-aligned arrows.
class AppTooltip extends StatefulWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.supportingText,
    this.arrow = TooltipArrow.topCenter,
    this.viewportPadding = EdgeInsets.zero,
    this.viewportMaxWidth = double.infinity,
  }) : assert(viewportMaxWidth >= 0);
  final String message;
  final String? supportingText;
  final TooltipArrow arrow;

  /// Insets the tooltip body boundary within its nearest overlay's safe area.
  /// Independent of content padding and the gap to the target.
  final EdgeInsets viewportPadding;

  /// Centers a maximum-width boundary in the safe overlay before applying padding.
  /// Does not constrain the target or the overlay itself.
  final double viewportMaxWidth;
  final Widget child;
  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip>
    with SingleTickerProviderStateMixin {
  final _portal = OverlayPortalController();
  final _geometry = ValueNotifier<FPortalGeometry?>(null);
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
    reverseDuration: const Duration(milliseconds: 75),
  );
  Timer? _timer;
  bool _held = false;
  void _show() {
    _timer?.cancel();
    _portal.show();
    if (MediaQuery.disableAnimationsOf(context)) {
      _animation.value = 1;
    } else {
      _animation.forward();
    }
  }

  void _hide() {
    _timer?.cancel();
    if (_held) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _animation.value = 0;
      _portal.hide();
    } else {
      _animation.reverse();
    }
  }

  void _schedule(Duration delay, VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void _hoverEnter() {
    if (_portal.isShowing) {
      _show();
      return;
    }
    _schedule(
      TooltipTheme.of(context).waitDuration ??
          const Duration(milliseconds: 500),
      _show,
    );
  }

  void _hoverExit() {
    _schedule(const Duration(milliseconds: 100), _hide);
  }

  @override
  void initState() {
    super.initState();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) _portal.hide();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animation.dispose();
    _geometry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.viewportPadding.isNonNegative);
    final v = context.ui;
    final arrow = widget.arrow;
    final (tipAnchor, childAnchor) = switch (arrow) {
      TooltipArrow.none ||
      TooltipArrow.topCenter => (Alignment.topCenter, Alignment.bottomCenter),
      TooltipArrow.bottomCenter => (
        Alignment.bottomCenter,
        Alignment.topCenter,
      ),
      TooltipArrow.bottomLeft => (Alignment.bottomLeft, Alignment.topCenter),
      TooltipArrow.bottomRight => (Alignment.bottomRight, Alignment.topCenter),
      TooltipArrow.left => (Alignment.centerLeft, Alignment.centerRight),
      TooltipArrow.right => (Alignment.centerRight, Alignment.centerLeft),
    };
    final contentPadding = EdgeInsets.symmetric(
      horizontal: v.space(3),
      vertical: v.space(widget.supportingText == null ? 2 : 3),
    );
    final spacing = _tooltipSpacing(
      childAnchor,
      tipAnchor,
      v.space(2) + (arrow == TooltipArrow.none ? 0 : 6),
      cornerInset:
          arrow == TooltipArrow.bottomLeft || arrow == TooltipArrow.bottomRight
          ? 20
          : 0,
    );
    final base = ShapeDecoration(
      color: v.colors.bgPrimarySolid,
      shadows: v.effects.shadowLg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(v.radii.md),
      ),
    );
    final decoration = arrow == TooltipArrow.none
        ? base
        : FPortalArrowDecoration(
            style: const FPortalArrowStyle(
              width: 16,
              height: 6,
              baseRadius: 0,
              tipRadius: 0,
            ),
            decoration: base,
            geometry: _geometry,
            alignment: FPortalArrowAlignment.childCenter,
          );
    final overlayMedia = MediaQuery.of(Overlay.of(context).context);
    final padding = overlayMedia.padding;
    final insets = overlayMedia.viewInsets;
    final safe = EdgeInsets.fromLTRB(
      math.max(padding.left, insets.left),
      math.max(padding.top, insets.top),
      math.max(padding.right, insets.right),
      math.max(padding.bottom, insets.bottom),
    );
    return Semantics(
      tooltip: widget.supportingText == null
          ? widget.message
          : '${widget.message}\n${widget.supportingText}',
      child: OverlayPortal.overlayChildLayoutBuilder(
        controller: _portal,
        overlayChildBuilder: (context, info) => _TooltipLayout(
          target: MatrixUtils.transformRect(
            info.childPaintTransform,
            Offset.zero & info.childSize,
          ),
          view: info.overlaySize,
          maxWidth: widget.supportingText == null ? double.infinity : 320,
          safe: safe,
          viewportPadding: widget.viewportPadding,
          viewportMaxWidth: widget.viewportMaxWidth,
          contentPadding: contentPadding,
          targetAnchor: childAnchor,
          tipAnchor: tipAnchor,
          spacing: spacing,
          geometry: _geometry,
          child: MouseRegion(
            onEnter: (_) => _hoverEnter(),
            onExit: (_) => _hoverExit(),
            child: FadeTransition(
              opacity: _animation,
              child: _buildTooltipBody(context, decoration, contentPadding),
            ),
          ),
        ),
        child: Focus(
          canRequestFocus: false,
          onKeyEvent: (_, event) {
            if (event.logicalKey == LogicalKeyboardKey.escape &&
                event is! KeyUpEvent &&
                _portal.isShowing) {
              _hide();
              return KeyEventResult.handled;
            }
            return KeyEventResult.ignored;
          },
          onFocusChange: (focused) => focused ? _hoverEnter() : _hide(),
          child: MouseRegion(
            onEnter: (_) => _hoverEnter(),
            onExit: (_) => _hoverExit(),
            child: Listener(
              onPointerDown: (_) => _hide(),
              child: GestureDetector(
                onLongPressStart: (_) {
                  _held = true;
                  Feedback.forLongPress(context);
                  _show();
                },
                onLongPressEnd: (_) {
                  _held = false;
                  _schedule(
                    TooltipTheme.of(context).showDuration ??
                        const Duration(milliseconds: 1500),
                    _hide,
                  );
                },
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTooltipBody(
    BuildContext context,
    Decoration decoration,
    EdgeInsets contentPadding,
  ) {
    final v = context.ui;
    return Semantics(
      container: true,
      child: DecoratedBox(
        decoration: decoration,
        child: Padding(
          padding: contentPadding,
          child: DefaultTextStyle(
            style: v.text.textXs.copyWith(
              color: v.colors.textWhite,
              fontWeight: FontWeight.w600,
            ),
            child: SingleChildScrollView(
              primary: false,
              child: _buildTooltipContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTooltipContent(BuildContext context) {
    final v = context.ui;
    final supporting = widget.supportingText;
    return supporting == null
        ? Text(widget.message)
        : SizedBox(
            width: 296,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: v.space(.5),
              children: [
                Text(widget.message),
                Text(
                  supporting,
                  style: v.text.textXs.copyWith(
                    color: v.colors.tooltipSupportingText,
                  ),
                ),
              ],
            ),
          );
  }
}

/// Fixed design offsets applied before Forui's collision handling.
Offset _tooltipSpacing(
  Alignment child,
  Alignment portal,
  double gap, {
  double cornerInset = 0,
}) => FPortalSpacing(gap)(child, portal) + Offset(portal.x * cornerInset, 0);

({
  BoxConstraints constraints,
  Alignment childAnchor,
  Alignment portalAnchor,
  Offset spacing,
})
_availableSpaceSizing(
  Size view,
  Rect target,
  Size naturalSize,
  Alignment childAnchor,
  Alignment portalAnchor,
  Offset spacing,
) {
  final horizontal = childAnchor.y == portalAnchor.y;
  final gap = horizontal ? spacing.dx.abs() : spacing.dy.abs();
  final preferred = horizontal
      ? (childAnchor.x < 0 ? AxisDirection.left : AxisDirection.right)
      : (childAnchor.y < 0 ? AxisDirection.up : AxisDirection.down);
  final slots = <AxisDirection, Size>{
    AxisDirection.up: Size(
      view.width,
      (target.top - gap).clamp(0.0, view.height),
    ),
    AxisDirection.down: Size(
      view.width,
      (view.height - target.bottom - gap).clamp(0.0, view.height),
    ),
    AxisDirection.left: Size(
      (target.left - gap).clamp(0.0, view.width),
      view.height,
    ),
    AxisDirection.right: Size(
      (view.width - target.right - gap).clamp(0.0, view.width),
      view.height,
    ),
  };
  final order = [
    preferred,
    flipAxisDirection(preferred),
    ...AxisDirection.values.where(
      (d) => axisDirectionToAxis(d) != axisDirectionToAxis(preferred),
    ),
  ];
  AxisDirection? selected;
  for (final side in order) {
    final room = slots[side]!;
    if (room.width >= naturalSize.width && room.height >= naturalSize.height) {
      selected = side;
      break;
    }
  }
  selected ??= order.reduce((a, b) {
    double score(AxisDirection d) {
      final s = slots[d]!;
      return math.min(naturalSize.width, s.width) * s.height;
    }

    return score(a) >= score(b) ? a : b;
  });
  final room = slots[selected]!;
  final targetAnchor = switch (selected) {
    AxisDirection.up => Alignment.topCenter,
    AxisDirection.down => Alignment.bottomCenter,
    AxisDirection.left => Alignment.centerLeft,
    AxisDirection.right => Alignment.centerRight,
  };
  return (
    constraints: BoxConstraints(
      maxWidth: math.min(naturalSize.width, room.width),
      maxHeight: room.height,
    ),
    childAnchor: selected == preferred ? childAnchor : targetAnchor,
    portalAnchor: selected == preferred ? portalAnchor : -targetAnchor,
    spacing: selected == preferred
        ? spacing
        : FPortalSpacing(gap)(targetAnchor, -targetAnchor),
  );
}

class _TooltipLayout extends SingleChildRenderObjectWidget {
  const _TooltipLayout({
    required this.target,
    required this.view,
    required this.maxWidth,
    required this.safe,
    required this.viewportPadding,
    required this.viewportMaxWidth,
    required this.contentPadding,
    required this.targetAnchor,
    required this.tipAnchor,
    required this.spacing,
    required this.geometry,
    required super.child,
  });
  final Rect target;
  final Size view;
  final double maxWidth;
  final EdgeInsets safe;
  final EdgeInsets viewportPadding;
  final double viewportMaxWidth;
  final EdgeInsets contentPadding;
  final Alignment targetAnchor, tipAnchor;
  final Offset spacing;
  final ValueNotifier<FPortalGeometry?> geometry;
  @override
  _RenderTooltipLayout createRenderObject(BuildContext context) =>
      _RenderTooltipLayout(this);
  @override
  void updateRenderObject(
    BuildContext context,
    _RenderTooltipLayout renderObject,
  ) => renderObject.update(this);
}

/// Measure and constrain in the same layout pass, before Forui positions the tip.
class _RenderTooltipLayout extends RenderShiftedBox {
  _RenderTooltipLayout(this.config) : super(null);
  _TooltipLayout config;
  bool _visible = true;
  void update(_TooltipLayout value) {
    config = value;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    size = constraints.constrain(Size(config.view.width, config.view.height));
    final outerMargin = math.max(
      0.0,
      (size.width - config.safe.horizontal - config.viewportMaxWidth) / 2,
    );
    final safe =
        config.safe +
        EdgeInsets.symmetric(horizontal: outerMargin) +
        config.viewportPadding;
    final view = Size(
      math.max(0, size.width - safe.horizontal),
      math.max(0, size.height - safe.vertical),
    );
    final target = config.target.shift(-safe.topLeft);
    child!.layout(
      BoxConstraints(
        maxWidth: math.min(config.maxWidth, view.width),
        maxHeight: view.height,
      ),
      parentUsesSize: true,
    );
    final chosen = _availableSpaceSizing(
      view,
      target,
      child!.size,
      config.targetAnchor,
      config.tipAnchor,
      config.spacing,
    );
    final wasVisible = _visible;
    _visible =
        chosen.constraints.maxWidth > config.contentPadding.horizontal &&
        chosen.constraints.maxHeight > config.contentPadding.vertical &&
        config.safe.deflateRect(Offset.zero & size).overlaps(config.target);
    if (_visible != wasVisible) markNeedsSemanticsUpdate();
    child!.layout(chosen.constraints, parentUsesSize: true);
    final offset =
        target.topLeft +
        FPortalOverflow.slide(
          view,
          (
            offset: target.topLeft,
            size: target.size,
            anchor: chosen.childAnchor,
          ),
          (
            offset: chosen.spacing,
            size: child!.size,
            anchor: chosen.portalAnchor,
          ),
        ) +
        safe.topLeft;
    (child!.parentData! as BoxParentData).offset = offset;
    config.geometry.value = (
      child: config.target.shift(-offset),
      portal: child!.size,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_visible) super.paint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      _visible && super.hitTestChildren(result, position: position);

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (_visible) super.visitChildrenForSemantics(visitor);
  }
}
