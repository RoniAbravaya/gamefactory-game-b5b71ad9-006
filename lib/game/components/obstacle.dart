import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:testLast-puzzle-06/player.dart';

/// Represents an obstacle in the game.
class Obstacle extends PositionComponent with Hitbox, Collidable {
  final Sprite _sprite;
  final double _speed;
  final double _damage;

  /// Constructs an Obstacle with the given sprite, speed, and damage.
  Obstacle(Vector2 position, this._sprite, this._speed, this._damage)
      : super(position: position, size: _sprite.size);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= _speed * dt;

    // Wrap around the screen if the obstacle goes off-screen
    if (position.x < -size.x) {
      position.x = game.size.x + size.x;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.render(canvas, position: position, size: size);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    if (other is Player) {
      other.takeDamage(_damage);
    }
  }
}