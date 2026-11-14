import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';

import '../../theme.dart';
import '../internal/focus_ring.dart';
import '../internal/pointer_feedback.dart';
import '../internal/delegating_ripple_factory.dart';

enum TabButtonStyle { underline, line, brand, gray, white, minimal }

enum TabSize { sm, md }

/// Inputs for a base-fill animation; geometry and focus decoration stay shared.
typedef TabFillAnimation = ({
  Color targetColor,
  Color selectedColor,
  Color focusColor,
  bool selected,
  bool focused,
  bool mouseActivation,
  Duration duration,
});

typedef TabFillAnimationBuilder = Widget Function(
  BuildContext context,
  TabFillAnimation animation,
  Widget Function(Color color) paint,
);

/// Supplies touch/keyboard ink. TabButton still suppresses mouse ripples.
typedef TabRippleFactoryBuilder = InteractiveInkFeatureFactory Function(
  ValueGetter<Color> color,
);

/// Selection and navigation belong to the parent; Flutter owns interaction state.
class TabButton extends StatefulWidget {
  const TabButton({
    super.key,
    required this.label,
    this.selected = false,
    this.onPressed,
    this.style = TabButtonStyle.underline,
    this.size = TabSize.sm,
    this.leading,
    this.badge,
    this.fillAnimationBuilder,
    this.rippleFactoryBuilder,
  });

  final TabButtonStyle style;
  final TabSize size;
  final String label;
  final bool selected;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? badge;

  /// Overrides only base-fill interpolation, not content or focus decoration.
  /// Fixed line indicators and white/minimal selection surfaces stay unchanged.
  final TabFillAnimationBuilder? fillAnimationBuilder;
  final TabRippleFactoryBuilder? rippleFactoryBuilder;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  Color _rippleColor = Colors.transparent;
  final _pointerFeedback = PointerFeedback();
  // Ink highlights can outlive pointer-up; keep their device policy until the
  // next activation. The factory also resets it for keyboard activation.
  bool _suppressPressedOverlay = false;
  late final _rippleFactory = DelegatingRippleFactory(
    resolveFactory: () {
      _suppressPressedOverlay =
          _pointerFeedback.kind == PointerDeviceKind.mouse;
      return _suppressPressedOverlay
          ? NoSplash.splashFactory
          : widget.rippleFactoryBuilder?.call(() => _rippleColor) ??
                InkRipple.splashFactory;
    },
    resolveColor: (color) => _suppressPressedOverlay ? color : _rippleColor,
  );

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final size = widget.size;
    final selected = widget.selected;
    final onPressed = widget.onPressed;
    final label = widget.label;
    final leading = widget.leading;
    final badge = widget.badge;
    final v = context.ui;
    final c = v.colors;
    _rippleColor = switch (style) {
      TabButtonStyle.brand => c.bgBrandPrimaryAlt,
      TabButtonStyle.gray => c.bgPrimaryHover,
      TabButtonStyle.white || TabButtonStyle.minimal => c.bgPrimaryAlt,
      TabButtonStyle.line => c.textSecondary.withValues(alpha: .1),
      TabButtonStyle.underline => Colors.transparent,
    };
    final underline = style == TabButtonStyle.underline;
    final line = style == TabButtonStyle.line;
    final flat = underline || line;
    final brand = flat || style == TabButtonStyle.brand;
    final minimal = style == TabButtonStyle.minimal;
    final md = size == TabSize.md;
    final radius = flat
        ? 0.0
        : minimal
        ? v.radii.md
        : v.radii.xs;
    final typography = md ? v.text.textMd : v.text.textSm;
    final button = TextButton(
      onPressed: onPressed,
      clipBehavior: Clip.none,
      style: ButtonStyle(
        mouseCursor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.disabled)
              ? SystemMouseCursors.forbidden
              : null;
        }),
        animationDuration: Duration.zero,
        splashFactory: underline ? NoSplash.splashFactory : _rippleFactory,
        backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        minimumSize: WidgetStatePropertyAll(
          Size(
            0,
            flat
                ? 0
                : md
                ? 44
                : 36,
          ),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.standard,
        padding: WidgetStatePropertyAll(
          underline
              ? EdgeInsets.fromLTRB(v.space(.5), 0, v.space(.5), v.space(3))
              : line
              ? EdgeInsets.symmetric(
                  horizontal: v.space(3),
                  vertical: v.space(.5),
                )
              : EdgeInsets.symmetric(
                  horizontal: v.space(2.5),
                  vertical: v.space(2),
                ),
        ),
        textStyle: WidgetStatePropertyAll(
          typography.copyWith(fontWeight: FontWeight.w600),
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (states) => selected || states.contains(WidgetState.hovered)
              ? brand
                    ? c.textBrandSecondary
                    : c.textSecondary
              : c.textQuaternary,
        ),
        overlayColor: WidgetStateProperty.resolveWith(
          (states) =>
              !underline &&
                  !_suppressPressedOverlay &&
                  states.contains(WidgetState.pressed)
              ? _rippleColor
              : Colors.transparent,
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
        backgroundBuilder: (context, states, child) => _TabBackground(
          style: style,
          selected: selected,
          states: states,
          radius: radius,
          fillAnimationBuilder: widget.fillAnimationBuilder,
          mouseActivation: _suppressPressedOverlay,
          child: child,
        ),
      ),
      child: _TabContent(
        label: label,
        size: size,
        leading: leading,
        badge: badge,
      ),
    );
    return _pointerFeedback.wrap(
      Semantics(
        selected: selected,
        child: minimal || style == TabButtonStyle.white
            ? _TabSelectionSurface(
                selected: selected,
                radius: radius,
                minimal: minimal,
                child: button,
              )
            : button,
      ),
    );
  }
}

class _TabBackground extends StatelessWidget {
  const _TabBackground({
    required this.style,
    required this.selected,
    required this.states,
    required this.radius,
    required this.fillAnimationBuilder,
    required this.mouseActivation,
    required this.child,
  });

  final TabButtonStyle style;
  final bool selected;
  final Set<WidgetState> states;
  final double radius;
  final TabFillAnimationBuilder? fillAnimationBuilder;
  final bool mouseActivation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    final c = v.colors;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final duration = disableAnimations
        ? Duration.zero
        : const Duration(milliseconds: 100);
    final underline = style == TabButtonStyle.underline;
    final line = style == TabButtonStyle.line;
    final flat = underline || line;
    final minimal = style == TabButtonStyle.minimal;
    final white = style == TabButtonStyle.white;
    final hover = states.contains(WidgetState.hovered);
    final focus = states.contains(WidgetState.focused);
    final selectedFill = switch (style) {
      TabButtonStyle.brand => c.bgBrandPrimaryAlt,
      TabButtonStyle.gray => c.bgPrimaryHover,
      _ => c.bgPrimaryAlt,
    };
    final fill = flat
        ? Colors.transparent
        : white || minimal
        ? focus && !selected
              ? c.bgPrimary
              : c.bgPrimary.withValues(alpha: 0)
        : selected
        ? selectedFill
        : focus
        ? c.bgPrimary
        : selectedFill.withValues(alpha: 0);
    final indicatorColor = selected || hover
        ? c.fgBrandPrimaryAlt
        : Colors.transparent;
    Widget decorate(Color? color, Widget? child) => Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        Positioned.fill(
          child: Ink(
            decoration: BoxDecoration(
              color: flat ? Colors.transparent : color,
              borderRadius: flat ? null : BorderRadius.circular(radius),
              border: underline
                  ? Border(bottom: BorderSide(color: color!, width: 2))
                  : line
                  ? Border(left: BorderSide(color: color!, width: 2))
                  : null,
            ),
          ),
        ),
        child!,
        if (!flat)
          Positioned.fill(
            child: FocusRing(
              visible: focus,
              radius: radius,
              color: c.focusRing,
              duration: duration,
            ),
          ),
      ],
    );
    final animateFill = fillAnimationBuilder;
    if (!flat && animateFill != null) {
      return animateFill(context, (
        targetColor: fill,
        selectedColor: selectedFill,
        focusColor: c.bgPrimary,
        selected: selected,
        focused: focus,
        mouseActivation: mouseActivation,
        duration: duration,
      ), (color) => decorate(color, child));
    }
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: flat ? indicatorColor : fill),
      duration: duration,
      curve: Curves.linear,
      builder: (context, color, child) => decorate(color, child),
      child: child,
    );
  }
}

// Composite the opaque fill and shadow before fading them, below the native
// button Material. Text, focus ink and ripples are outside this opacity layer.
class _TabSelectionSurface extends StatelessWidget {
  const _TabSelectionSurface({
    required this.selected,
    required this.radius,
    required this.minimal,
    required this.child,
  });

  final bool selected, minimal;
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: selected ? 1 : 0,
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 100),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: v.colors.bgPrimaryAlt,
                  borderRadius: BorderRadius.circular(radius),
                  border: minimal
                      ? Border.all(color: v.colors.borderPrimary)
                      : null,
                  boxShadow: minimal
                      ? [v.effects.shadowXs]
                      : v.effects.shadowSm,
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class _TabContent extends StatelessWidget {
  const _TabContent({
    required this.label,
    required this.size,
    required this.leading,
    required this.badge,
  });

  final String label;
  final TabSize size;
  final Widget? leading;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final leading = this.leading;
    final badge = this.badge;
    final v = context.ui;
    final md = size == TabSize.md;
    final target = DefaultTextStyle.of(context).style.color;
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: target),
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 100),
      curve: Curves.linear,
      builder: (context, color, child) => DefaultTextStyle.merge(
        style: TextStyle(color: color),
        child: IconTheme.merge(
          data: IconThemeData(color: color),
          child: child!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (leading != null) ...[
            IconTheme.merge(
              data: IconThemeData(size: md ? 24 : 20),
              child: leading,
            ),
            SizedBox(width: v.space(1)),
          ],
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: v.space(.5)),
              child: Text(label, textAlign: TextAlign.center),
            ),
          ),
          if (badge != null) ...[SizedBox(width: v.space(1)), badge],
        ],
      ),
    );
  }
}
