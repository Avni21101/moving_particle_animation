import 'dart:ui';

class Particle {
  Particle({
    required this.position,
    required this.speed,
    required this.delta,
    required this.color,
    required this.radius,
  });
  Offset position;
  double speed;
  double delta;
  Color color;
  double radius;
}
