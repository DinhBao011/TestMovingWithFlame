import 'package:flame/game.dart';
import 'package:test_move_flame/Action/action.dart';
import 'package:test_move_flame/figure/button.dart';
import 'package:test_move_flame/figure/player.dart';

class MyGame extends FlameGame {
  late final Player player;
  final double speed = 300;
  final double gravity = 400, jumpSpeed = -500;

  // Trạng thái của các nút điều khiển
  bool isMovingLeft = false;
  bool isMovingRight = false;

  double groundY = 0.0; // Tọa độ y của mặt đất

  @override
  Future<void> onLoad() async {
    // Xác định mặt đất (groundY)
    groundY = size.y - 200;

    // Khởi tạo player
    player = Player()
      ..position = Vector2(size.x / 2, groundY)
      ..size = Vector2.all(50);
    add(player);

    // Thêm các nút điều khiển
    add(createButton(
      text: '<',
      position: Vector2(50, size.y - 100),
      onPressed: () => isMovingLeft = true,
      onReleased: () => isMovingLeft = false,
    ));

    add(createButton(
      text: '>',
      position: Vector2(150, size.y - 100),
      onPressed: () => isMovingRight = true,
      onReleased: () => isMovingRight = false,
    ));

    add(createButton(
      text: 'jump',
      position: Vector2(size.x / 2 + 300, size.y - 100),
      onPressed: () => jump(player, jumpSpeed, groundY),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Di chuyển nhân vật trái/phải
    if (isMovingLeft) {
      movePlayer(Vector2(-1, 0), dt, speed, player, size);
    }

    if (isMovingRight) {
      movePlayer(Vector2(1, 0), dt, speed, player, size);
    }

    // Áp dụng trọng lực và cập nhật vị trí
    applyGravity(player, gravity, dt, groundY);
  }
}
