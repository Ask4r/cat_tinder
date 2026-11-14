import 'package:flutter/material.dart';

import 'package:cat_tinder/state/appearance.dart';
import 'package:cat_tinder/ui/theme.dart';
import 'package:cat_tinder/ui/widgets/application/tab_button.dart';

/// Appearance controls keep their ink and fill synchronized with AnimatedTheme.
class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final Appearance value;
  final ValueChanged<Appearance> onChanged;

  @override
  Widget build(BuildContext context) => Row(
    spacing: context.ui.space(1),
    children: [
      for (final appearance in Appearance.values)
        Expanded(
          child: TabButton(
            style: TabButtonStyle.gray,
            fillAnimationBuilder: _animateThemeFill,
            rippleFactoryBuilder: _ThemeRippleFactory.new,
            label: switch (appearance) {
              Appearance.light => 'Light',
              Appearance.dark => 'Dark',
              Appearance.system => 'System',
            },
            selected: appearance == value,
            onPressed: () {
              if (appearance != value) onChanged(appearance);
            },
          ),
        ),
    ],
  );
}

Widget _animateThemeFill(
  BuildContext context,
  TabFillAnimation animation,
  Widget Function(Color color) paint,
) {
  final waitForRipple = animation.selected && !animation.mouseActivation;
  return TweenAnimationBuilder<double>(
    tween: Tween<double>(end: animation.focused ? 1 : 0),
    duration: animation.duration,
    builder: (context, focus, _) => TweenAnimationBuilder<double>(
      tween: Tween<double>(end: animation.selected ? 1 : 0),
      // Touch/keyboard selection is revealed once the native ink fills it.
      duration: waitForRipple && animation.duration != Duration.zero
          ? const Duration(milliseconds: 225)
          : animation.duration,
      curve: waitForRipple ? const Threshold(1) : Curves.linear,
      builder: (context, selection, _) => paint(
        Color.lerp(
          Color.lerp(
            animation.selectedColor.withValues(alpha: 0),
            animation.focusColor,
            focus,
          ),
          animation.selectedColor,
          selection,
        )!,
      ),
    ),
  );
}

// InkWell stops recoloring a splash after release. Resolve the live theme color
// without changing InkRipple's expansion, opacity animation or disposal.
class _ThemeRippleFactory extends InteractiveInkFeatureFactory {
  const _ThemeRippleFactory(this.resolveColor);
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
  }) {
    return _ThemeInkRipple(
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
