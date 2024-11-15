import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame {
  late final Player player;
  final double speed = 100;

  // Trạng thái của các nút di chuyển
  bool isMovingLeft = false;
  bool isMovingRight = false;

  @override
  Future<void> onLoad() async {
    // Khởi tạo player ở vị trí trung tâm màn hình với kích thước 50x50
    player = Player()
      ..position = size / 2
      ..size = Vector2.all(50);
    add(player);

    // Tạo nút di chuyển trái
    add(createButton(
      text: '<',
      position: Vector2(50, size.y - 100),
      direction: Vector2(-1, 0),
      onPressed: () => isMovingLeft = true, // Khi nhấn giữ, update trạng thái
      onReleased: () => isMovingLeft = false, // Khi nhả nút, dừng di chuyển
    ));

    // Tạo nút di chuyển phải
    add(createButton(
      text: '>',
      position: Vector2(150, size.y - 100),
      direction: Vector2(1, 0),
      onPressed: () => isMovingRight = true, // Khi nhấn giữ, update trạng thái
      onReleased: () => isMovingRight = false, // Khi nhả nút, dừng di chuyển
    ));
  }

  // Hàm tạo nút di chuyển để tránh lặp lại code
  HudButtonComponent createButton({
    required String text,
    required Vector2 position,
    required Vector2 direction,
    required VoidCallback onPressed,
    required VoidCallback onReleased,
  }) {
    return HudButtonComponent(
      button: TextComponent(
        text: text,
        textRenderer:
            TextPaint(style: const TextStyle(color: Colors.blue, fontSize: 24)),
      ),
      onPressed: onPressed,
      onReleased: onReleased, // Sử dụng lastDt ở đây
      position: position,
      size: Vector2.all(50),
    );
  }

  // Hàm di chuyển nhân vật theo hướng nhất định
  void movePlayer(Vector2 direction, double dt) {
    // Tính toán vị trí mới của player
    Vector2 newPosition = player.position + direction * speed * dt;

    // Giới hạn vị trí trong màn hình
    newPosition.clamp(Vector2.zero(), size - player.size);

    // Cập nhật vị trí mới của player
    player.position = newPosition;
  }

  // Để lưu giá trị dt của frame cuối cùng
  double lastDt = 0.0;

  @override
  void update(double dt) {
    super.update(dt);
    lastDt = dt; // Lưu lại giá trị dt mới nhất để sử dụng khi nhấn nút

    //Di chuyển khi các nút được nhấn giữ
    if (isMovingLeft) {
      movePlayer(Vector2(-1, 0), dt);
    }

    if (isMovingRight) {
      movePlayer(Vector2(1, 0), dt);
    }
  }
}

// Vẽ player trên canvas
class Player extends PositionComponent {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), Paint()..color = Colors.blue);
  }
}
