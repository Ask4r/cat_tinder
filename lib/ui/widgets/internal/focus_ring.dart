import 'package:flutter/widgets.dart';

/// Paint-only focus decoration. The owner supplies focus state and timing.
class FocusRing extends StatelessWidget {
  const FocusRing({
    super.key,
    required this.visible,
    required this.radius,
    required this.color,
    required this.duration,
  });

  final bool visible;
  final double radius;
  final Color color;
  final Duration duration;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: duration,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: color, width: 2, strokeAlign: 3),
        ),
      ),
    ),
  );
}
