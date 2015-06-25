part of dartsnake;

/**
 * Constant to define the speed of a [Snake].
 * A [snakeSpeed] of 250ms means 4 movements per second.
 */
const snakeSpeed = const Duration(milliseconds: 250);

/**
 * Constant to define the speed of a [Mouse].
 * A [miceSpeed] of 1000ms means 1 movement per second.
 */
const miceSpeed = const Duration(milliseconds: 1000);

/**
 * A [SnakeGameController] object registers several handlers
 * to grab interactions of a user with a [RaumffischGame] and translate
 * them into valid [RaumffischGame] actions.
 *
 * Furthermore a [SnakeGameController] object triggers the
 * movements of a [Snake] object and (several) [Mouse] objects
 * of a [RaumffischGame].
 *
 * Necessary updates of the view are delegated to a [SnakeView] object
 * to inform the user about changing [RaumffischGame] states.
 */
class SnakeGameController {

  /**
   * Referencing the to be controlled model.
   */
  var game = new RaumffischGame(gamesize);

  /**
   * Referencing the presenting view.
   */
  final view = new SnakeView();

  /**
   * Periodic trigger controlling snake movement.
   */
  Timer snakeTrigger;

  /**
   * Periodic trigger controlling mice movement.
   */
  Timer miceTrigger;

  /**
   * Constructor to create a controller object.
   * Registers all necessary event handlers necessary
   * for the user to interact with a [RaumffischGame].
   */
  SnakeGameController() {

    // New game is started by user
    view.startButton.onClick.listen((_) {
      if (snakeTrigger != null) snakeTrigger.cancel();
      if (miceTrigger != null) miceTrigger.cancel();
      game = new RaumffischGame(gamesize);
      view.generateField(game);
      snakeTrigger = new Timer.periodic(snakeSpeed, (_) => _moveSnake());
      miceTrigger = new Timer.periodic(miceSpeed, (_) => _moveMice());
      game.start();
      view.update(game);
    });

    // Steering of the snake
    window.onKeyDown.listen((KeyboardEvent ev) {
      if (game.stopped) return;
      switch (ev.keyCode) {
        
        //Ffisch nach links bewegen
        case KeyCode.LEFT:  game.snake.headLeft(); break;
        //Ffisch nach recht bewegen
        case KeyCode.RIGHT: game.snake.headRight(); break;
        //Ffisch nach oben bewegen
        case KeyCode.UP:    game.snake.headUp(); break;
        //Ffisch nach unten bewegen
        case KeyCode.DOWN:  game.snake.headDown(); break;
        //Feuern
        case KeyCode.SPACE: /**/ break;
        //Spiel anhalten
        case KeyCode.PAUSE: /**/ break;
        //PowerUp benutzen
        case KeyCode.ALT: /**/ break;
        
        
        
      }
    });
  }

  /**
   * Moves all mice.
   */
  void _moveMice() {
    if (game.gameOver) { game.stop(); view.update(game); return; }
    game.moveMice();
    view.update(game);
  }

  /**
   * Moves the snake.
   */
  void _moveSnake() {
    if (game.gameOver) { game.stop(); view.update(game); return; }
    final mice = game.miceCounter;
    game.moveSnake();
    if (game.miceCounter > mice) { _increaseSnakeSpeed(); }
    if (game.gameOver) return;
    view.update(game);
  }

  /**
   * Increases Snake speed by 1% for every eaten mouse.
   */
  void _increaseSnakeSpeed() {
    snakeTrigger.cancel();
    final newSpeed = snakeSpeed * pow(0.99, game.miceCounter);
    snakeTrigger = new Timer.periodic(newSpeed, (_) => _moveSnake());
  }
}
