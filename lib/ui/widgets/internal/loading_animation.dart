import 'package:cat_tinder/environment.dart';
import 'package:flutter/material.dart';

class LoadingRotation extends StatelessWidget {
  const LoadingRotation({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => LoadingAnimation(
    builder: (animation) => RotationTransition(turns: animation, child: child),
  );
}

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key, required this.builder});
  final Widget Function(Animation<double>) builder;

  @override
  State<LoadingAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingAnimation>
    with SingleTickerProviderStateMixin {
  late final _animation = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    if (disableInfiniteAnimations) {
      _animation.reset();
    } else if (reducedMotion) {
      _animation.stop();
    } else if (!_animation.isAnimating) {
      _animation.repeat();
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(_animation);
}
