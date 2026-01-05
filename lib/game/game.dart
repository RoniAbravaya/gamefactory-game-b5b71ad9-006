import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:testLast-puzzle-06/analytics_service.dart';
import 'package:testLast-puzzle-06/game_controller.dart';
import 'package:testLast-puzzle-06/level_config.dart';
import 'package:testLast-puzzle-06/player.dart';
import 'package:testLast-puzzle-06/ui_overlay.dart';

/// The main game class for the 'testLast-puzzle-06' game.
class testLast-puzzle-06Game extends FlameGame with TapDetector {
  /// The current game state.
  GameState _gameState = GameState.playing;

  /// The player object.
  late Player _player;

  /// The game controller.
  late GameController _gameController;

  /// The analytics service.
  late AnalyticsService _analyticsService;

  /// The current level configuration.
  late LevelConfig _levelConfig;

  /// The player's score.
  int _score = 0;

  /// The player's lives.
  int _lives = 3;

  @override
  Future<void> onLoad() async {
    // Set up the camera and world
    camera.viewport = FixedResolutionViewport(Vector2(480, 800));
    camera.followComponent(_player);

    // Load the level configuration
    _levelConfig = await LevelConfig.load('level1.json');

    // Create the player
    _player = Player(position: _levelConfig.playerStartPosition);
    add(_player);

    // Create the game controller
    _gameController = GameController(this, _player);
    add(_gameController);

    // Create the UI overlay
    final uiOverlay = UIOverlay(this, _gameController);
    overlays.add('ui', uiOverlay);

    // Initialize the analytics service
    _analyticsService = AnalyticsService();
    _analyticsService.logGameStart();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    _gameController.handleTap(info.eventPosition.game);
  }

  /// Updates the player's score.
  void updateScore(int points) {
    _score += points;
    _analyticsService.logScoreUpdate(_score);
  }

  /// Decrements the player's lives.
  void decrementLives() {
    _lives--;
    if (_lives <= 0) {
      _gameState = GameState.gameOver;
      _analyticsService.logGameOver();
    }
  }

  /// Checks if the level is complete.
  bool isLevelComplete() {
    return _levelConfig.isComplete();
  }

  /// Handles level completion.
  void handleLevelComplete() {
    _gameState = GameState.levelComplete;
    _analyticsService.logLevelComplete();
  }

  /// Handles game over.
  void handleGameOver() {
    _gameState = GameState.gameOver;
    _analyticsService.logGameOver();
  }

  /// Handles pausing the game.
  void handlePause() {
    _gameState = GameState.paused;
    _analyticsService.logGamePaused();
  }

  /// Handles resuming the game.
  void handleResume() {
    _gameState = GameState.playing;
    _analyticsService.logGameResumed();
  }
}

/// The possible game states.
enum GameState {
  playing,
  paused,
  gameOver,
  levelComplete,
}