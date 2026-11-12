import 'dart:math' as math;

/// Page-owned rotational feedback; translation still follows the pointer directly.
class CardTilt {
  double angle = 0;
  double _position = 0;
  double _velocity = 0;
  double _angularVelocity = 0;

  void reset() {
    angle = 0;
    _position = 0;
    _velocity = 0;
    _angularVelocity = 0;
  }

  /// Returns whether the motion has settled. Position is in logical pixels.
  bool advance(double seconds, double position) {
    // Normalize pixels to movement units. Use bounded integration steps so
    // rotation stays stable across refresh rates and delayed frames.
    final target = position / 100;
    var remaining = seconds.clamp(0.0, .1);
    while (remaining > 0) {
      final dt = math.min(remaining, 1 / 120);
      final movementDamping = math.exp(-50 * dt);
      _velocity =
          movementDamping * _velocity +
          (1 - movementDamping) * (target - _position) * 35;
      _velocity = _velocity.clamp(-70.0, 70.0);
      _position += _velocity * dt;

      final targetAngle = (.015 * _velocity).clamp(-.22, .22);
      final rotationDamping = math.exp(-190 * dt);
      // Convert the original per-frame angular step to radians per second
      // using a 60Hz reference, then integrate with elapsed time.
      _angularVelocity =
          rotationDamping * _angularVelocity +
          (1 - rotationDamping) * (targetAngle - angle) * 60;
      angle += _angularVelocity * dt;
      remaining -= dt;
    }
    if ((target - _position).abs() < .0001 &&
        _velocity.abs() < .01 &&
        angle.abs() < .001 &&
        _angularVelocity.abs() < .06) {
      _position = target;
      _velocity = 0;
      angle = 0;
      _angularVelocity = 0;
      return true;
    }
    return false;
  }
}
