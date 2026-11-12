import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';

import '../theme.dart';
import 'app_icon.dart';
import 'loading_indicator.dart';

enum AppButtonSize { xs, sm, md, lg, xl }

enum AppButtonHierarchy { primary, secondary, tertiary, linkColor, linkGray }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.icon,
    this.trailingIcon,
    this.onPressed,
    this.primary = false,
    this.size = AppButtonSize.xl,
    this.link = false,
    this.hierarchy,
    this.loading = false,
    this.loadingLabel = 'Submitting...',
    this.iconOnly = false,
  }) : assert(!iconOnly || icon != null),
       assert(
         !iconOnly ||
             (hierarchy != AppButtonHierarchy.linkColor &&
                 hierarchy != AppButtonHierarchy.linkGray &&
                 !link),
       );
  final AppButtonHierarchy? hierarchy;
  final bool loading;
  final String loadingLabel;
  final bool iconOnly;
  final String label;
  final String? icon;
  final String? trailingIcon;
  final VoidCallback? onPressed;
  final bool primary;
  final AppButtonSize size;
  final bool link;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  final _states = WidgetStatesController();
  bool _hovering = false;
  PointerDeviceKind? _pointerKind;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  @override
  void didUpdateWidget(AppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // InkWell remembers pointer entry while disabled, but does not restore
    // WidgetState.hovered when enabling under a stationary pointer.
    if ((oldWidget.onPressed != null && !oldWidget.loading) != _enabled) {
      _states.update(WidgetState.hovered, _enabled && _hovering);
    }
  }

  @override
  void dispose() {
    _states.dispose();
    super.dispose();
  }

  Widget _input(Widget child) => MouseRegion(
    // Observe presence only; InkWell owns normal hover state updates.
    onEnter: (_) => _hovering = true,
    onExit: (_) => _hovering = false,
    child: Listener(
      // These passive events only select splash feedback, never activation.
      onPointerDown: (event) => _pointerKind = event.kind,
      onPointerUp: (_) => _pointerKind = null,
      onPointerCancel: (_) => _pointerKind = null,
      child: child,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final icon = widget.icon;
    final size = widget.size;
    final onPressed = widget.onPressed;
    final loading = widget.loading;
    final label = widget.label;
    final loadingLabel = widget.loadingLabel;
    final iconOnly = widget.iconOnly;
    final trailingIcon = widget.trailingIcon;
    final hierarchy =
        widget.hierarchy ??
        (widget.link
            ? AppButtonHierarchy.linkColor
            : widget.primary
            ? AppButtonHierarchy.primary
            : AppButtonHierarchy.secondary);
    final primary = hierarchy == AppButtonHierarchy.primary;
    final secondary = hierarchy == AppButtonHierarchy.secondary;
    final tertiary = hierarchy == AppButtonHierarchy.tertiary;
    final link =
        hierarchy == AppButtonHierarchy.linkColor ||
        hierarchy == AppButtonHierarchy.linkGray;
    final colorLink = hierarchy == AppButtonHierarchy.linkColor;
    final callback = loading ? null : onPressed;
    final disabled = !loading && onPressed == null;
    final iconSize = size == AppButtonSize.xs ? 16.0 : 20.0;
    final variables = context.ui;
    final colors = variables.colors;
    final smallText =
        size == AppButtonSize.xs ||
        size == AppButtonSize.sm ||
        size == AppButtonSize.md;
    final height = switch (size) {
      AppButtonSize.xs => 32.0,
      AppButtonSize.sm => 36.0,
      AppButtonSize.md => 40.0,
      AppButtonSize.lg => 44.0,
      AppButtonSize.xl => 48.0,
    };
    final horizontalSpace = switch (size) {
      AppButtonSize.xs => 2.0,
      AppButtonSize.sm => 2.5,
      AppButtonSize.md => 3.0,
      AppButtonSize.lg => 3.5,
      AppButtonSize.xl => 4.0,
    };
    final radius = link ? variables.radii.sm : variables.radii.md;
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : const Duration(milliseconds: 100);
    final style = ButtonStyle(
      animationDuration: duration,
      splashFactory: _ButtonRippleFactory(
        suppress: () => _pointerKind == PointerDeviceKind.mouse,
        fadeCancellation: primary || secondary,
      ),
      overlayColor: WidgetStateProperty.resolveWith((states) {
        if (primary || secondary) return null;
        if (states.contains(WidgetState.pressed)) {
          return null;
        }
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused)) {
          return Colors.transparent;
        }
        return null;
      }),
      elevation: const WidgetStatePropertyAll(0),
      visualDensity: VisualDensity.standard,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: WidgetStatePropertyAll(
        link ? Size.zero : Size(height, height),
      ),
      padding: WidgetStatePropertyAll(
        link || iconOnly
            ? EdgeInsets.zero
            : EdgeInsets.symmetric(
                horizontal:
                    variables.space(horizontalSpace) +
                    (smallText
                        ? (primary
                              ? 2
                              : secondary
                              ? 1
                              : 0)
                        : 0),
                vertical: variables.space((height - (smallText ? 20 : 24)) / 8),
              ),
      ),
      textStyle: WidgetStatePropertyAll(
        (smallText ? variables.typography.textSm : variables.typography.textMd)
            .copyWith(fontWeight: FontWeight.w600),
      ),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        final hover =
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed) ||
            loading;
        final color = colorLink
            ? (hover
                  ? colors.textBrandSecondaryHover
                  : colors.textBrandSecondary)
            : primary
            ? colors.textWhite
            : (hover ? colors.textSecondaryHover : colors.textSecondary);
        return color;
      }),
      backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
      backgroundBuilder: (context, states, child) => _ButtonBackground(
        hierarchy: hierarchy,
        loading: loading,
        states: states,
        radius: radius,
        duration: duration,
        child: child,
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      ),
      side: const WidgetStatePropertyAll(BorderSide.none),
    );
    final content = _ButtonContent(
      icon: icon,
      trailingIcon: trailingIcon,
      iconSize: iconSize,
      iconOnly: iconOnly,
      loading: loading,
      label: label,
      loadingLabel: loadingLabel,
      link: link,
    );
    final accessibleContent = iconOnly
        ? Semantics(
            label: label,
            child: ExcludeSemantics(child: content),
          )
        : content;
    final Widget button = link || tertiary
        ? TextButton(
            style: style,
            statesController: _states,
            clipBehavior: Clip.none,
            onPressed: callback,
            child: accessibleContent,
          )
        : primary
        ? _FilledRippleButton(
            style: style,
            statesController: _states,
            clipBehavior: Clip.none,
            onPressed: callback,
            child: accessibleContent,
          )
        : _OutlinedRippleButton(
            style: style,
            statesController: _states,
            clipBehavior: Clip.none,
            onPressed: callback,
            child: accessibleContent,
          );
    final sizedButton = iconOnly
        ? SizedBox(width: height, height: height, child: button)
        : button;
    if (link || tertiary) {
      return _input(
        AnimatedOpacity(
          opacity: disabled ? .5 : 1,
          duration: duration,
          child: sizedButton,
        ),
      );
    }
    final shadow = primary
        ? variables.effects.shadowXs
        : variables.effects.shadowSecondaryXs;
    return _input(
      AnimatedOpacity(
        opacity: disabled ? .5 : 1,
        duration: duration,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [shadow],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: primary
                  ? colors.bgBrandSolidHover
                  : colors.bgPrimaryHover,
            ),
            child: sizedButton,
          ),
        ),
      ),
    );
  }
}

class _ButtonBackground extends StatelessWidget {
  const _ButtonBackground({
    required this.hierarchy,
    required this.loading,
    required this.states,
    required this.radius,
    required this.duration,
    required this.child,
  });

  final AppButtonHierarchy hierarchy;
  final bool loading;
  final Set<WidgetState> states;
  final double radius;
  final Duration duration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final variables = context.ui;
    final colors = variables.colors;
    final primary = hierarchy == AppButtonHierarchy.primary;
    final secondary = hierarchy == AppButtonHierarchy.secondary;
    final tertiary = hierarchy == AppButtonHierarchy.tertiary;
    final link =
        hierarchy == AppButtonHierarchy.linkColor ||
        hierarchy == AppButtonHierarchy.linkGray;
    final hover = states.contains(WidgetState.hovered) || loading;
    final color = link
        ? (states.contains(WidgetState.focused)
              ? colors.bgPrimary
              : Colors.transparent)
        : tertiary
        ? (hover
              ? colors.bgPrimaryHover
              : states.contains(WidgetState.focused)
              ? colors.bgPrimary
              : Colors.transparent)
        : primary
        ? (hover ? colors.bgBrandSolidHover : colors.bgBrandSolid)
        : (hover ? colors.bgPrimaryHover : colors.bgPrimary);
    final fill = color;
    final inset = variables.effects.skeuomorphic;
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(end: fill),
      duration: duration,
      builder: (context, color, child) => Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Ink(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
          if (primary && !link) ...[
            Positioned.fill(
              child: IgnorePointer(
                child: ShaderMask(
                  shaderCallback: inset.highlight.createShader,
                  blendMode: BlendMode.srcIn,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border(bottom: inset.bottom),
                  ),
                ),
              ),
            ),
          ],
          if (secondary)
            Positioned.fill(
              child: IgnorePointer(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: colors.borderPrimary, width: 1),
                  ),
                ),
              ),
            ),
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: states.contains(WidgetState.focused) ? 1 : 0,
                duration: duration,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: colors.focusRing,
                      width: 2,
                      strokeAlign: 3,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ?child,
        ],
      ),
      child: child,
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.icon,
    required this.trailingIcon,
    required this.iconSize,
    required this.iconOnly,
    required this.loading,
    required this.label,
    required this.loadingLabel,
    required this.link,
  });

  final String? icon;
  final String? trailingIcon;
  final double iconSize;
  final bool iconOnly;
  final bool loading;
  final String label;
  final String loadingLabel;
  final bool link;

  @override
  Widget build(BuildContext context) {
    final icon = this.icon;
    final trailingIcon = this.trailingIcon;
    final spinner = Builder(
      builder: (context) =>
          LoadingIndicator(size: iconSize, color: IconTheme.of(context).color),
    );
    return iconOnly
        ? (loading
              ? spinner
              : Opacity(opacity: .6, child: AppIcon(icon!, size: iconSize)))
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) ...[
                spinner,
                SizedBox(width: context.ui.space(1)),
              ] else if (icon != null) ...[
                Opacity(opacity: .6, child: AppIcon(icon, size: iconSize)),
                SizedBox(width: context.ui.space(1)),
              ],
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: link ? 0 : context.ui.space(1),
                  ),
                  child: Text(
                    loading ? loadingLabel : label,
                    textAlign: TextAlign.center,
                    textHeightBehavior: const TextHeightBehavior(
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
                  ),
                ),
              ),
              if (!loading && trailingIcon != null) ...[
                SizedBox(width: context.ui.space(1)),
                Opacity(
                  opacity: .6,
                  child: AppIcon(trailingIcon, size: iconSize),
                ),
              ],
            ],
          );
  }
}

// A null overlay lets InkWell use its separate transparent highlight and the
// theme splash color. Remove all overlay fallbacks, not just the local style.
const _noOverlay = WidgetStatePropertyAll<Color?>(null);

class _FilledRippleButton extends FilledButton {
  const _FilledRippleButton({
    required super.onPressed,
    required super.child,
    super.style,
    super.clipBehavior,
    super.statesController,
  });

  @override
  ButtonStyle defaultStyleOf(BuildContext context) =>
      super.defaultStyleOf(context).copyWith(overlayColor: _noOverlay);

  @override
  ButtonStyle? themeStyleOf(BuildContext context) =>
      super.themeStyleOf(context)?.copyWith(overlayColor: _noOverlay);
}

class _OutlinedRippleButton extends OutlinedButton {
  const _OutlinedRippleButton({
    required super.onPressed,
    required super.child,
    super.style,
    super.clipBehavior,
    super.statesController,
  });

  @override
  ButtonStyle defaultStyleOf(BuildContext context) =>
      super.defaultStyleOf(context).copyWith(overlayColor: _noOverlay);

  @override
  ButtonStyle? themeStyleOf(BuildContext context) =>
      super.themeStyleOf(context)?.copyWith(overlayColor: _noOverlay);
}

// Complete the native expansion/fade on cancellation instead of compressing it
// into InkRipple's 75ms cancellation timeline. This does not activate the button.
class _ButtonRippleFactory extends InteractiveInkFeatureFactory {
  const _ButtonRippleFactory({
    required this.suppress,
    required this.fadeCancellation,
  });
  final bool Function() suppress;
  final bool fadeCancellation;

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
    final suppressSplash = suppress();
    if (suppressSplash || !fadeCancellation) {
      return (suppressSplash ? NoSplash.splashFactory : InkRipple.splashFactory)
          .create(
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
    return _FadingCancelRipple(
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

class _FadingCancelRipple extends InkRipple {
  _FadingCancelRipple({
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

  @override
  void cancel() => super.confirm();
}
