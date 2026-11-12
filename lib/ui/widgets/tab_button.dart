import 'package:flutter/material.dart';

import '../theme.dart';

enum TabButtonStyle { underline, line, brand, gray, white, minimal }

enum TabSize { sm, md }

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
  });

  final TabButtonStyle style;
  final TabSize size;
  final String label;
  final bool selected;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? badge;

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  Color _rippleColor = Colors.transparent;
  late final _rippleFactory = _ThemeInkRippleFactory(() => _rippleColor);

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
    _rippleColor = c.bgPrimaryHover;
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
        : v.radii.sm;
    final typography = md ? v.text.textMd : v.text.textSm;
    return Semantics(
      selected: selected,
      child: TextButton(
        onPressed: onPressed,
        clipBehavior: Clip.none,
        style: ButtonStyle(
          animationDuration: Duration.zero,
          splashFactory: underline
              ? NoSplash.splashFactory
              : style == TabButtonStyle.gray
              ? _rippleFactory
              : InkRipple.splashFactory,
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
            (states) => !underline && states.contains(WidgetState.pressed)
                ? style == TabButtonStyle.gray
                      ? c.bgPrimaryHover
                      : c.textSecondary.withValues(alpha: .1)
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
            child: child,
          ),
        ),
        child: _TabContent(
          label: label,
          size: size,
          leading: leading,
          badge: badge,
        ),
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
    required this.child,
  });

  final TabButtonStyle style;
  final bool selected;
  final Set<WidgetState> states;
  final double radius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final v = context.ui;
    final c = v.colors;
    final underline = style == TabButtonStyle.underline;
    final line = style == TabButtonStyle.line;
    final flat = underline || line;
    final minimal = style == TabButtonStyle.minimal;
    final white = style == TabButtonStyle.white;
    final hover = states.contains(WidgetState.hovered);
    final focus = states.contains(WidgetState.focused);
    final grayInteraction = style == TabButtonStyle.gray && hover;
    final selectedFill = switch (style) {
      TabButtonStyle.brand => c.bgBrandPrimaryAlt,
      TabButtonStyle.gray => c.bgPrimaryHover,
      _ => c.bgPrimaryAlt,
    };
    final fill = flat
        ? Colors.transparent
        : selected || grayInteraction
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
                  : minimal && selected
                  ? Border.all(color: c.borderPrimary)
                  : null,
              boxShadow: [
                if (selected && minimal) v.effects.shadowXs,
                if (selected && white) ...v.effects.shadowSm,
              ],
            ),
          ),
        ),
        child!,
        if (!underline)
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: focus ? 1 : 0,
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 200),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: c.focusRing,
                      width: 2,
                      strokeAlign: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
    if (style == TabButtonStyle.gray) {
      return TweenAnimationBuilder<Offset>(
        tween: Tween<Offset>(end: Offset(hover ? 1 : 0, focus ? 1 : 0)),
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 200),
        curve: Curves.linear,
        builder: (context, amount, child) => TweenAnimationBuilder<double>(
          tween: Tween<double>(end: selected ? 1 : 0),
          // Native InkRipple finishes its confirmed expansion within 225ms.
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : Duration(milliseconds: selected ? 225 : 200),
          curve: selected ? const Threshold(1) : Curves.linear,
          builder: (context, selection, child) => decorate(
            Color.lerp(
              Color.lerp(
                amount.dy == 0
                    ? selectedFill.withValues(alpha: 0)
                    : Color.lerp(
                        selectedFill.withValues(alpha: 0),
                        c.bgPrimary,
                        amount.dy,
                      ),
                selectedFill,
                amount.dx,
              ),
              selectedFill,
              selection,
            ),
            child,
          ),
          child: child,
        ),
        child: child,
      );
    }
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: flat ? indicatorColor : fill),
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 200),
      curve: Curves.linear,
      builder: (context, color, child) => decorate(color, child),
      child: child,
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
          : const Duration(milliseconds: 200),
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
            IconTheme(
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

// InkWell stops recoloring a splash after release. Resolve the live theme color
// without changing InkRipple's expansion, opacity animation or disposal.
class _ThemeInkRippleFactory extends InteractiveInkFeatureFactory {
  const _ThemeInkRippleFactory(this.resolveColor);
  final ValueGetter<Color> resolveColor;

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) => _ThemeInkRipple(
    resolveColor: resolveColor,
    controller: controller,
    referenceBox: referenceBox,
    position: position,
    color: color,
    textDirection: textDirection,
    containedInkWell: containedInkWell,
    rectCallback: rectCallback,
    borderRadius: borderRadius,
    customBorder: customBorder,
    radius: radius,
    onRemoved: onRemoved,
  );
}

class _ThemeInkRipple extends InkRipple {
  _ThemeInkRipple({
    required this.resolveColor,
    required super.controller,
    required super.referenceBox,
    required super.position,
    required super.color,
    required super.textDirection,
    super.containedInkWell,
    super.rectCallback,
    super.borderRadius,
    super.customBorder,
    super.radius,
    super.onRemoved,
  });

  final ValueGetter<Color> resolveColor;

  @override
  Color get color => resolveColor();
}
