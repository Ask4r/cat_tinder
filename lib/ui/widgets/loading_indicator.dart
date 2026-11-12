import '../theme.dart';

import 'package:flutter/material.dart';

import 'app_icon.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key, this.size = 32, this.color});
  final double size;
  final Color? color;
  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final _rotation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _rotation.stop();
    } else {
      _rotation.repeat();
    }
  }

  @override
  void dispose() {
    _rotation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading',
    child: RotationTransition(
      turns: _rotation,
      child: AppIcon(
        'loading',
        size: widget.size,
        color: widget.color ?? context.ui.colors.fgQuaternary,
      ),
    ),
  );
}
