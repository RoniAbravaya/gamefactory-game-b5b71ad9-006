import 'package:flame/components.dart';
import 'package:flame/audio.dart';
import 'package:flutter/material.dart';

/// A collectible item component for a puzzle game.
class Collectible extends SpriteComponent with CollisionCallbacks {
  final int scoreValue;
  final Audio _collectSound;

  /// Creates a new instance of the [Collectible] component.
  ///
  /// [sprite] is the sprite to be displayed for the collectible.
  /// [position] is the initial position of the collectible.
  /// [scoreValue] is the score value awarded when the collectible is picked up.
  /// [collectSound] is the audio to be played when the collectible is collected.
  Collectible({
    required Sprite sprite,
    required Vector2 position,
    required this.scoreValue,
    required Audio collectSound,
  })  : _collectSound = collectSound,
        super(
          sprite: sprite,
          position: position,
          size: Vector2.all(32.0),
        );

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    _collectSound.play();
    removeFromParent();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    addComponent(
      AnimationComponent(
        animation: Animation.spriteList([
          sprite,
          Sprite(await images.fromCache('collectible_spin_1.png')),
          Sprite(await images.fromCache('collectible_spin_2.png')),
        ], stepTime: 0.3, loop: true),
        position: position,
        size: size,
      ),
    );
  }
}