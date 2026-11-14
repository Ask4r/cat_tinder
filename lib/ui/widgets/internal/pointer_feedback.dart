import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/widgets.dart';

/// Passive press-device observation. The native button still owns activation.
/// Keep one instance per control; this neither changes hover nor requests rebuilds.
class PointerFeedback {
  PointerDeviceKind? _kind;

  PointerDeviceKind? get kind => _kind;

  Widget wrap(Widget child) => Listener(
    onPointerDown: (event) => _kind = event.kind,
    onPointerUp: (_) => _kind = null,
    onPointerCancel: (_) => _kind = null,
    child: child,
  );
}
