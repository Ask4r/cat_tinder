import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:cat_tinder/state/discovery.dart';

import '../../layouts/application_layout.dart';
import 'discovery_status.dart';
import 'web_photograph.dart';

/// Owns photograph rendering and readiness for one discovery encounter.
class DiscoveryPhotograph extends StatefulWidget {
  const DiscoveryPhotograph({
    super.key,
    required this.encounter,
    required this.onReady,
    required this.onDecodeFailure,
    required this.onRetry,
    required this.onSkip,
  });

  final Encounter encounter;
  final VoidCallback onReady;
  final VoidCallback onDecodeFailure;
  final VoidCallback onRetry;
  final VoidCallback onSkip;

  @override
  State<DiscoveryPhotograph> createState() => _DiscoveryPhotographState();
}

class _DiscoveryPhotographState extends State<DiscoveryPhotograph> {
  bool _ready = false;
  bool _reportedFailure = false;
  Timer? _decodeDeadline;

  @override
  void didUpdateWidget(covariant DiscoveryPhotograph oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.encounter.bytes, widget.encounter.bytes) ||
        (oldWidget.encounter.photoFailed && !widget.encounter.photoFailed)) {
      _ready = false;
      _reportedFailure = false;
      _decodeDeadline?.cancel();
    }
  }

  void _decoded() {
    if (_ready || !mounted || widget.encounter.photoFailed) return;
    _decodeDeadline?.cancel();
    setState(() => _ready = true);
    widget.onReady();
  }

  void _failed() {
    if (_reportedFailure || !mounted) return;
    _reportedFailure = true;
    _decodeDeadline?.cancel();
    widget.onDecodeFailure();
  }

  @override
  void dispose() {
    _decodeDeadline?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final encounter = widget.encounter;
    if ((kIsWeb || encounter.bytes != null) &&
        !encounter.photoFailed &&
        !_ready &&
        !_reportedFailure &&
        !(_decodeDeadline?.isActive ?? false)) {
      _decodeDeadline = Timer(Duration(seconds: kIsWeb ? 9 : 3), _failed);
    }
    return SizedBox(
      height:
          MediaQuery.sizeOf(context).width >=
              ApplicationLayout.desktopBreakpoint
          ? 360
          : 300,
      child: encounter.photoFailed
          ? DiscoveryRecovery(
              message: "This cat photo couldn't load.",
              onRetry: () async {
                if (kIsWeb) {
                  await webPhotograph(encounter.image.url).evict();
                }
                if (mounted) widget.onRetry();
              },
              onSkip: widget.onSkip,
            )
          : !kIsWeb && encounter.bytes == null
          ? DiscoveryLoading(compact: true)
          : Image(
              image: kIsWeb
                  ? webPhotograph(encounter.image.url)
                  : MemoryImage(encounter.bytes!),
              fit: BoxFit.cover,
              semanticLabel:
                  'Photograph of a ${encounter.image.breeds.first.name} cat',
              frameBuilder: (context, child, frame, synchronous) {
                if (frame != null || synchronous) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _decoded(),
                  );
                  return child;
                }
                return DiscoveryLoading(compact: true);
              },
              errorBuilder: (context, error, stack) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _failed());
                return DiscoveryLoading(compact: true);
              },
            ),
    );
  }
}
