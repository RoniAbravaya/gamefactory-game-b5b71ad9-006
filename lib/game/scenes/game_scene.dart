import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// The main game scene that handles level loading, player and object spawning,
/// game loop logic, score display, and pause/resume functionality.
class GameScene extends Component with HasGameRef {
  /// The player component.
  late Player player;

  /// The list of obstacles in the current level.
  final List<Obstacle> obstacles = [];

  /// The list of collectibles in the current level.
  final List<Collectible> collectibles = [];

  /// The current score of the player.
  int score = 0;

  /// Whether the game is currently paused.
  bool isPaused = false;

  @override
  Future<void> onLoad() async {
    /// Load the current level
    await _loadLevel();

    /// Spawn the player
    _spawnPlayer();

    /// Spawn obstacles and collectibles
    _spawnObstacles();
    _spawnCollectibles();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isPaused) {
      /// Update player
      player.update(dt);

      /// Update obstacles
      for (final obstacle in obstacles) {
        obstacle.update(dt);
      }

      /// Update collectibles
      for (final collectible in collectibles) {
        collectible.update(dt);
      }

      /// Check for collisions
      _checkCollisions();

      /// Check for win/lose conditions
      _checkGameState();
    }
  }

  /// Loads the current level and sets up the game scene.
  Future<void> _loadLevel() async {
    // Load level data from a file or database
    // and initialize the level-specific components
  }

  /// Spawns the player in the game scene.
  void _spawnPlayer() {
    player = Player(position: Vector2(50, gameRef.size.y - 100));
    add(player);
  }

  /// Spawns the obstacles in the game scene.
  void _spawnObstacles() {
    // Spawn obstacles based on the current level data
    for (final obstacleData in levelData.obstacles) {
      final obstacle = Obstacle(position: obstacleData.position);
      obstacles.add(obstacle);
      add(obstacle);
    }
  }

  /// Spawns the collectibles in the game scene.
  void _spawnCollectibles() {
    // Spawn collectibles based on the current level data
    for (final collectibleData in levelData.collectibles) {
      final collectible = Collectible(position: collectibleData.position);
      collectibles.add(collectible);
      add(collectible);
    }
  }

  /// Checks for collisions between the player, obstacles, and collectibles.
  void _checkCollisions() {
    // Check for collisions and handle them accordingly
    if (player.isColliding(obstacles)) {
      // Handle player-obstacle collision
    }

    if (player.isColliding(collectibles)) {
      // Handle player-collectible collision
      _collectItem(collectibles.firstWhere((c) => player.isColliding(c)));
    }
  }

  /// Handles the collection of a collectible item.
  void _collectItem(Collectible collectible) {
    // Update the score
    score += collectible.value;

    // Remove the collected item from the scene
    collectibles.remove(collectible);
    remove(collectible);
  }

  /// Checks the current game state and determines if the player has won or lost.
  void _checkGameState() {
    // Check if the player has won or lost the current level
    if (player.hasWon()) {
      // Handle level completion
      _completeLevel();
    } else if (player.hasLost()) {
      // Handle level failure
      _failLevel();
    }
  }

  /// Completes the current level and moves to the next one.
  void _completeLevel() {
    // Save the player's score
    // Unlock the next level if applicable
    // Transition to the next level or the level selection screen
  }

  /// Handles the failure of the current level.
  void _failLevel() {
    // Reset the level or show a game over screen
  }

  /// Pauses the game.
  void pauseGame() {
    isPaused = true;
    // Pause all game components
  }

  /// Resumes the game.
  void resumeGame() {
    isPaused = false;
    // Resume all game components
  }
}