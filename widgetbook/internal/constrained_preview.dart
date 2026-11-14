import 'dart:math' as math;

import 'package:cat_tinder/ui/theme.dart';
import 'package:flutter/material.dart';

/// Catalog-only constraint guide; adds no padding, clipping or hit targets.
class ConstrainedPreview extends StatelessWidget {
  const ConstrainedPreview({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => CustomPaint(
    foregroundPainter: _DashedBorder(context.ui.colors.borderSecondary),
    child: child,
  );
}

class _DashedBorder extends CustomPainter {
  const _DashedBorder(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width < 1 || size.height < 1) return;
    final path = Path()..addRect((Offset.zero & size).deflate(0.5));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in path.computeMetrics()) {
      for (double start = 0; start < metric.length; start += 8) {
        canvas.drawPath(
          metric.extractPath(start, math.min(start + 4, metric.length)),
          paint,
        );
      }
    }
  }

  @override
  bool? hitTest(Offset position) => false;

  @override
  bool shouldRepaint(_DashedBorder oldDelegate) => color != oldDelegate.color;
}
