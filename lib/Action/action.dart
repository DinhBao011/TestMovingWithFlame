import 'package:flame/extensions.dart';
import '../figure/player.dart';

void movePlayer(Vector2 direction, double dt, double speed, Player player,
    Vector2 screenSize) {
  Vector2 newPosition = player.position + direction * speed * dt;
  newPosition.clamp(Vector2.zero(), screenSize - player.size);
  player.position = newPosition;
}

void applyGravity(Player player, double gravity, double dt, double groundY) {
// Áp dụng trọng lực
  player.velocityY += gravity * dt;

  // Cập nhật vị trí dọc
  player.position.y += player.velocityY * dt;

  // Giới hạn để không rơi xuyên qua mặt đất
  if (player.position.y >= groundY) {
    player.position.y = groundY;
    player.velocityY = 0.0; // Reset tốc độ khi chạm đất
  }
}

void jump(Player player, double jumpSpeed, double groundY) {
  // Kiểm tra nếu Player đang ở trên mặt đất, cho phép nhảy
  if (player.position.y >= groundY) {
    player.velocityY = jumpSpeed; // Gán tốc độ nhảy ngay lập tức
  }
}
