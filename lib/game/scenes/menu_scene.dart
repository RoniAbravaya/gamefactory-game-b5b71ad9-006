import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// The main menu scene for the puzzle game.
class MenuScene extends Component with HasGameRef {
  /// The title of the game.
  late final TextComponent _titleText;

  /// The button to start the game.
  late final ButtonComponent _playButton;

  /// The button to access the level select screen.
  late final ButtonComponent _levelSelectButton;

  /// The button to access the settings screen.
  late final ButtonComponent _settingsButton;

  /// The background animation.
  late final SpriteAnimationComponent _backgroundAnimation;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Create the title text
    _titleText = TextComponent(
      text: 'testLast-puzzle-06',
      position: gameRef.size / 2,
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 48.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    add(_titleText);

    // Create the play button
    _playButton = ButtonComponent(
      position: gameRef.size * Vector2(0.5, 0.6),
      size: Vector2(200, 60),
      onPressed: () {
        // Navigate to the game scene
      },
      child: TextComponent(
        text: 'Play',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
    add(_playButton);

    // Create the level select button
    _levelSelectButton = ButtonComponent(
      position: gameRef.size * Vector2(0.5, 0.7),
      size: Vector2(200, 60),
      onPressed: () {
        // Navigate to the level select screen
      },
      child: TextComponent(
        text: 'Level Select',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
    add(_levelSelectButton);

    // Create the settings button
    _settingsButton = ButtonComponent(
      position: gameRef.size * Vector2(0.5, 0.8),
      size: Vector2(200, 60),
      onPressed: () {
        // Navigate to the settings screen
      },
      child: TextComponent(
        text: 'Settings',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
    add(_settingsButton);

    // Create the background animation
    final spriteSheet = await gameRef.loadSpriteSheet(
      'background.png',
      srcSize: Vector2(100, 100),
      cols: 5,
      rows: 5,
    );
    _backgroundAnimation = SpriteAnimationComponent(
      animation: spriteSheet.createAnimation(0, end: 24, loop: true),
      position: gameRef.size / 2,
      size: gameRef.size,
    );
    add(_backgroundAnimation);
  }
}