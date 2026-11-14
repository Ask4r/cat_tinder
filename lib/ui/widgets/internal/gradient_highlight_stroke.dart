import 'package:flutter/widgets.dart';

/// Paint-only highlight stroke; the owner controls its position and layer order.
class GradientHighlightStroke extends StatelessWidget {
  const GradientHighlightStroke({
    super.key,
    required this.radius,
    required this.gradient,
  });

  final double radius;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: ShaderMask(
      shaderCallback: gradient.createShader,
      blendMode: BlendMode.srcIn,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: const Color(0xFFFFFFFF), width: 2),
        ),
      ),
    ),
  );
}
