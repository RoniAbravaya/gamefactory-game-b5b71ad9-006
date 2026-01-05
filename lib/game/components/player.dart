import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';

/// The player character in the puzzle game.
class Player extends SpriteAnimationComponent with HasGameRef, Collidable {
  /// The player's current health or lives.
  int _health = 3;

  /// The player's current score.
  int _score = 0;

  /// The player's current animation state.
  PlayerState _state = PlayerState.idle;

  /// Initializes the player component.
  Player({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load the player's sprite sheet and create the animation frames
    final spriteSheet = await gameRef.loadSpriteSheet(
      'player.png',
      srcSize: Vector2(32, 32),
    );

    animation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2.all(32),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update the player's animation state based on input
    switch (_state) {
      case PlayerState.idle:
        // Do nothing
        break;
      case PlayerState.moving:
        // Move the player based on input
        break;
      case PlayerState.jumping:
        // Apply jump physics to the player
        break;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    // Handle collisions with other game objects
    if (other is Enemy) {
      // Reduce player health on collision with an enemy
      _health--;
    }
  }

  /// Increases the player's score by the given amount.
  void addScore(int amount) {
    _score += amount;
  }

  /// Returns the player's current health or lives.
  int get health => _health;

  /// Returns the player's current score.
  int get score => _score;
}

/// The different states the player can be in.
enum PlayerState {
  idle,
  moving,
  jumping,
}