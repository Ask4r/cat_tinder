import 'package:flutter/material.dart';

import '../../theme.dart';
import '../internal/loading_animation.dart';
import 'app_icon.dart';

/// The compact icon spinner used by buttons.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 32, this.color});
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading',
    child: LoadingRotation(
      child: AppIcon(
        'loading',
        size: size,
        color: color ?? context.ui.colors.fgQuaternary,
      ),
    ),
  );
}
