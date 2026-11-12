import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:cat_tinder/state/discovery.dart';
import 'package:cat_tinder/ui/theme.dart';

import 'card_tilt.dart';
import 'discovery_card_footer.dart';
import 'discovery_photograph.dart';

class DiscoveryCard extends StatefulWidget {
  const DiscoveryCard({
    super.key,
    required this.encounter,
    required this.onDecision,
    required this.onRetry,
    required this.onSkip,
    required this.onDecodeFailure,
    required this.onReady,
  });
  final Encounter encounter;
  final ValueChanged<bool> onDecision;
  final VoidCallback onRetry;
  final VoidCallback onSkip;
  final VoidCallback onDecodeFailure;
  final VoidCallback onReady;

  @override
  State<DiscoveryCard> createState() => _DiscoveryCardState();
}

class _DiscoveryCardState extends State<DiscoveryCard>
    with SingleTickerProviderStateMixin {
  bool _ready = false;
  bool _decided = false;
  double _drag = 0;
  double _dragY = 0;
  double _dragStartY = 0;
  bool _dragging = false;
  double _tilt = 0;
  final _rotation = CardTilt();
  Duration _lastTiltTick = Duration.zero;
  late final Ticker _tiltTicker = createTicker(_updateTilt);

  void _updateTilt(Duration elapsed) {
    final seconds = (elapsed - _lastTiltTick).inMicroseconds / 1000000;
    _lastTiltTick = elapsed;
    setState(() {
      if (MediaQuery.disableAnimationsOf(context)) {
        _rotation.reset();
        _tilt = 0;
        _tiltTicker.stop();
        return;
      }
      final settled = _rotation.advance(seconds, _drag);
      _tilt = _rotation.angle;
      if (settled) _tiltTicker.stop();
    });
  }

  void _trackTilt() {
    if (MediaQuery.disableAnimationsOf(context)) return;
    if (!_tiltTicker.isActive) {
      _lastTiltTick = Duration.zero;
      _tiltTicker.start();
    }
  }

  @override
  void didUpdateWidget(covariant DiscoveryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.encounter.bytes, widget.encounter.bytes) ||
        (oldWidget.encounter.photoFailed && !widget.encounter.photoFailed)) {
      _ready = false;
    }
  }

  void _photographReady() {
    if (_ready || !mounted || widget.encounter.photoFailed) return;
    setState(() => _ready = true);
    widget.onReady();
  }

  void _decide(bool liked) {
    if (!_ready || _decided || widget.encounter.photoFailed) return;
    _tiltTicker.stop();
    setState(() {
      _decided = true;
      _tilt = liked ? .22 : -.22;
      _dragging = false;
      // Include the rotated card's height so its trailing corner clears the screen.
      final size = context.size!;
      final distance =
          MediaQuery.sizeOf(context).width + size.width + size.height;
      _drag = (liked ? 1 : -1) * distance;
    });
    widget.onDecision(liked);
  }

  void _resetDrag() {
    _tiltTicker.stop();
    setState(() {
      _tilt = 0;
      _dragging = false;
      _drag = 0;
      _dragY = 0;
    });
  }

  @override
  void dispose() {
    _tiltTicker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final encounter = widget.encounter;
    final enabled = _ready && !_decided && !encounter.photoFailed;
    final reducedMotion = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      identifier: 'cat_card',
      child: GestureDetector(
        onHorizontalDragStart: enabled
            ? (details) => setState(() {
                _tiltTicker.stop();
                _tilt = 0;
                _rotation.reset();
                _dragging = true;
                _drag = 0;
                _dragY = 0;
                _dragStartY = details.globalPosition.dy;
              })
            : null,
        onHorizontalDragUpdate: enabled
            ? (details) => setState(() {
                _drag += details.delta.dx;
                _trackTilt();
                _dragY = details.globalPosition.dy - _dragStartY;
              })
            : null,
        onHorizontalDragCancel: _resetDrag,
        onHorizontalDragEnd: enabled
            ? (_) {
                if (_drag.abs() >= 70) {
                  _decide(_drag > 0);
                } else {
                  _resetDrag();
                }
              }
            : null,
        child: AnimatedContainer(
          duration: _dragging || reducedMotion
              ? Duration.zero
              : Duration(milliseconds: _decided ? 340 : 180),
          curve: _decided ? Curves.easeIn : Curves.easeOutCubic,
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()
            ..translateByDouble(_drag, _dragY, 0, 1)
            ..rotateZ(reducedMotion ? 0 : _tilt),
          child: RepaintBoundary(
            child: Container(
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: context.ui.colors.bgPrimary,
                borderRadius: BorderRadius.circular(context.ui.radii.xl),
              ),
              foregroundDecoration: BoxDecoration(
                border: Border.all(color: context.ui.colors.borderSecondary),
                borderRadius: BorderRadius.circular(context.ui.radii.xl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DiscoveryPhotograph(
                    encounter: encounter,
                    onReady: _photographReady,
                    onDecodeFailure: widget.onDecodeFailure,
                    onRetry: widget.onRetry,
                    onSkip: widget.onSkip,
                  ),
                  DiscoveryCardFooter(
                    breedName: encounter.image.breeds.first.name,
                    enabled: enabled,
                    onDecision: _decide,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
