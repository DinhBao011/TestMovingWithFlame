import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Player extends PositionComponent {
  double velocityY = 0.0;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.blue);
  }
}
