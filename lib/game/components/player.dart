import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

/// The Player component for the puzzle game.
class Player extends SpriteAnimationComponent with HasGameRef {
  /// The player's current health.
  int _health = 100;

  /// The maximum health the player can have.
  static const int maxHealth = 100;

  /// The time the player is invulnerable after taking damage.
  static const double invulnerabilityDuration = 2.0;

  /// The time since the player last took damage.
  double _timeSinceLastDamage = 0.0;

  /// The player's movement speed.
  static const double moveSpeed = 200.0;

  /// The player's jump force.
  static const double jumpForce = 500.0;

  /// Whether the player is currently jumping.
  bool _isJumping = false;

  /// The player's current position.
  Vector2 _position = Vector2.zero();

  /// The player's current velocity.
  Vector2 _velocity = Vector2.zero();

  /// The player's animation states.
  late SpriteAnimation _idleAnimation;
  late SpriteAnimation _runAnimation;
  late SpriteAnimation _jumpAnimation;
  late SpriteAnimation _hurtAnimation;

  /// Initializes the Player component.
  Player() : super(size: Vector2(50, 50)) {
    _loadAnimations();
  }

  @override
  void onMount() {
    super.onMount();
    animation = _idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update player position and velocity
    _position += _velocity * dt;
    _velocity.x = 0;

    // Handle player movement
    if (gameRef.keyboard.isPressed(LogicalKeyboardKey.arrowLeft)) {
      _velocity.x = -moveSpeed;
      animation = _runAnimation;
    } else if (gameRef.keyboard.isPressed(LogicalKeyboardKey.arrowRight)) {
      _velocity.x = moveSpeed;
      animation = _runAnimation;
    } else {
      animation = _idleAnimation;
    }

    if (gameRef.keyboard.isPressed(LogicalKeyboardKey.arrowUp) && !_isJumping) {
      _velocity.y = -jumpForce;
      _isJumping = true;
      animation = _jumpAnimation;
    }

    // Handle player invulnerability
    _timeSinceLastDamage += dt;
    if (_timeSinceLastDamage < invulnerabilityDuration) {
      // Player is invulnerable
      alpha = 0.5;
    } else {
      alpha = 1.0;
    }

    // Update player position
    position = _position;
  }

  /// Damages the player, reducing their health.
  void takeDamage(int amount) {
    _health = (_health - amount).clamp(0, maxHealth);
    _timeSinceLastDamage = 0.0;
    animation = _hurtAnimation;
  }

  /// Loads the player's animation sprites.
  void _loadAnimations() {
    final spriteSheet = SpriteSheet(
      image: gameRef.images.fromCache('player.png'),
      srcSize: Vector2(50, 50),
    );

    _idleAnimation = spriteSheet.createAnimation(row: 0, cols: 4, stepTime: 0.2);
    _runAnimation = spriteSheet.createAnimation(row: 1, cols: 4, stepTime: 0.1);
    _jumpAnimation = spriteSheet.createAnimation(row: 2, cols: 2, stepTime: 0.2);
    _hurtAnimation = spriteSheet.createAnimation(row: 3, cols: 2, stepTime: 0.2);
  }
}