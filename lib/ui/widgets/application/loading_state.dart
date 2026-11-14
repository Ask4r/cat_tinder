import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme.dart';
import '../internal/loading_animation.dart';

enum LoadingStateStyle {
  lineSimple('line-simple'),
  lineSpinner('line-spinner'),
  dotCircle('dot-circle');

  const LoadingStateStyle(this.assetName);
  final String assetName;
}

enum LoadingStateSize {
  sm(32),
  md(48),
  lg(56),
  xl(64);

  const LoadingStateSize(this.dimension);
  final double dimension;
}

/// The dedicated Figma loading component, with optional supporting text.
class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
    this.style = LoadingStateStyle.lineSimple,
    this.size = LoadingStateSize.sm,
    this.text = 'Loading...',
  });

  final LoadingStateStyle style;
  final LoadingStateSize size;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final variables = context.ui;
    final large = size == LoadingStateSize.lg || size == LoadingStateSize.xl;
    // Preserve Figma's visible stroke overflow without enlarging its layout slot.
    final overflows = size == LoadingStateSize.xl;
    final left = overflows && style != LoadingStateStyle.lineSpinner
        ? -1.0
        : 0.0;
    final top = overflows ? -1.0 : 0.0;
    final width = size.dimension + (overflows ? (left == 0 ? 1 : 2) : 0);
    final height = size.dimension + (overflows ? 2 : 0);
    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: MouseRegion(
        cursor: SystemMouseCursors.wait,
        child: Semantics(
          label: text == null ? 'Loading' : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: variables.space(size == LoadingStateSize.xl ? 5 : 4),
            children: [
              if (style == LoadingStateStyle.dotCircle)
                LoadingAnimation(
                  builder: (animation) => SizedBox.square(
                    dimension: size.dimension,
                    child: CustomPaint(
                      painter: _DotCirclePainter(
                        animation: animation,
                        size: size,
                        color: variables.colors.fgBrandPrimary,
                      ),
                    ),
                  ),
                )
              else
                LoadingRotation(
                  child: SizedBox.square(
                    dimension: size.dimension,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: left,
                          top: top,
                          width: width,
                          height: height,
                          child: SvgPicture.asset(
                            'assets/icons/loading-${style.assetName}-${size.name}.svg',
                            excludeFromSemantics: true,
                            colorMapper: _LoadingColors(
                              foreground: variables.colors.fgBrandPrimary,
                              background: variables.colors.bgTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (text != null)
                Text(
                  text!,
                  textAlign: TextAlign.center,
                  style: (large ? variables.text.textLg : variables.text.textSm)
                      .copyWith(
                        color: variables.colors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingColors extends ColorMapper {
  const _LoadingColors({required this.foreground, required this.background});
  final Color foreground;
  final Color background;

  @override
  Color substitute(
    String? id,
    String elementName,
    String attributeName,
    Color color,
  ) => color == const Color(0xFFF5F5F5) ? background : foreground;

  @override
  bool operator ==(Object other) =>
      other is _LoadingColors &&
      foreground == other.foreground &&
      background == other.background;

  @override
  int get hashCode => Object.hash(foreground, background);
}

class _DotCirclePainter extends CustomPainter {
  _DotCirclePainter({
    required this.animation,
    required this.size,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final LoadingStateSize size;
  final Color color;

  @override
  void paint(Canvas canvas, Size canvasSize) {
    // Figma's dot counts and circle geometry, including exported overflow.
    final (count, radius, orbit, centerY) = switch (size) {
      LoadingStateSize.sm => (11, 2.0, 14.0, 16.0),
      LoadingStateSize.md => (16, 3.0, 21.0, 24.0),
      LoadingStateSize.lg => (19, 4.0, 25.0, 27.91406),
      LoadingStateSize.xl => (22, 4.0, 29.0, 31.70509),
    };
    final paint = Paint();
    for (var i = 0; i < count; i++) {
      final angle = i * 2 * math.pi / count;
      // Increasing phase moves the opacity sequence counterclockwise.
      final opacity = 1 - ((i + animation.value * count) % count) / count;
      paint.color = color.withValues(alpha: color.a * opacity);
      canvas.drawCircle(
        Offset(
          canvasSize.width / 2 - orbit * math.cos(angle),
          centerY - orbit * math.sin(angle),
        ),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DotCirclePainter oldDelegate) =>
      animation != oldDelegate.animation ||
      size != oldDelegate.size ||
      color != oldDelegate.color;
}
