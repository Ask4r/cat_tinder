import 'package:flutter/material.dart';

/// Resolves component-owned ink policy at activation, then forwards to Flutter.
class DelegatingRippleFactory extends InteractiveInkFeatureFactory {
  const DelegatingRippleFactory({
    required this.resolveFactory,
    this.resolveColor,
  });

  final ValueGetter<InteractiveInkFeatureFactory> resolveFactory;
  final Color Function(Color color)? resolveColor;

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
    // Resolve first: a component may retain the activation's device policy.
    final factory = resolveFactory();
    return factory.create(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: resolveColor?.call(color) ?? color,
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
