import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';

HudButtonComponent createButton({
  required String text,
  required Vector2 position,
  required VoidCallback onPressed,
  VoidCallback? onReleased,
  Vector2? size,
}) {
  return HudButtonComponent(
    button: TextComponent(
      text: text,
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.blue, fontSize: 24),
      ),
    ),
    position: position,
    size: size ?? Vector2.all(50), // Kích thước mặc định
    onPressed: onPressed,
    onReleased: onReleased,
  );
}
