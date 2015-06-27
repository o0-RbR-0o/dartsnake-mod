part of dartsnake;

/**
 * Constant to define the speed of a [Snake].
 * A [gameSpeed] of 250ms means 4 movements per second.
 */
const gameSpeed = const Duration(milliseconds: 2);

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
  RaumffischGame game;

  /**
   * Referencing the presenting view.
   */
  final view = new SnakeView();

  /**
   * Periodic trigger controlling snake movement.
   */
  Timer updateTrigger;

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
      if (updateTrigger != null) updateTrigger.cancel();
      if (miceTrigger != null) miceTrigger.cancel();
      game = new RaumffischGame(gamesize);
      view.generateField(game);
      updateTrigger = new Timer.periodic(gameSpeed, (_) => _update());
      miceTrigger = new Timer.periodic(miceSpeed, (_) => _moveMice());
      
    
      game.start();
      view.update(game);
    });

    // Steering of the snake
  
    window.onKeyDown.listen((KeyboardEvent ev) {
      if (game.stopped) return;
        
      
        //Ffisch nach links bewegen
        if(ev.keyCode==KeyCode.LEFT)
          game.ffisch.moveleft();
        //Ffisch nach recht bewegen
        if(ev.keyCode==KeyCode.RIGHT) 
          game.ffisch.moveright();
        //Ffisch nach oben bewegen
        if(ev.keyCode==KeyCode.UP)   
          game.ffisch.moveup();
        //Ffisch nach unten bewegen
        if(ev.keyCode==KeyCode.DOWN)  
          game.ffisch.movedown(); 
        //Feuern
        if(ev.keyCode==KeyCode.SPACE) 
          game.ffisch.shoot();/**/ 
        //Spiel anhalten
        if(ev.keyCode== KeyCode.PAUSE);/**/ 
       
        //PowerUp benutzen
        if(ev.keyCode== KeyCode.ALT); /**/ 
          
        
        
        
      
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
  void _update() {
    if (game.gameOver) { game.stop(); view.update(game); return; }
    final mice = game.miceCounter;
    game.update();
    if (game.miceCounter > mice) { _increaseSnakeSpeed(); }
    if (game.gameOver) return;
    view.update(game);
  }

  /**
   * Increases Snake speed by 1% for every eaten mouse.
   */
  void _increaseSnakeSpeed() {
    updateTrigger.cancel();
    final newSpeed = gameSpeed * pow(0.99, game.miceCounter);
    updateTrigger = new Timer.periodic(newSpeed, (_) => _update());
  }
}
