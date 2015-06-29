part of dartsnake;

/**
 * Constant to define the speed of a [Snake].
 * A [gameSpeed] of 250ms means 4 movements per second.
 */

const gameSpeed = const Duration(milliseconds: 20);







class MultiKeyController{
  HashMap<int,int> _pressedKeys = new HashMap<int,int>();
  
  MultiKeyController(){
    window.onKeyDown.listen((KeyboardEvent e) {
          if (!_pressedKeys.containsKey(e.keyCode))
            _pressedKeys[e.keyCode] = e.timeStamp;
        });

        window.onKeyUp.listen((KeyboardEvent e) {
          _pressedKeys.remove(e.keyCode);
    });
        
  }
  isPressed(int keyCode) => _pressedKeys.containsKey(keyCode);
}


/**
 * A [GameController] object registers several handlers
 * to grab interactions of a user with a [RaumffischGame] and translate
 * them into valid [RaumffischGame] actions.
 *
 * Furthermore a [GameController] object triggers the
 * movements of a [Snake] object and (several) [Mouse] objects
 * of a [RaumffischGame].
 *
 * Necessary updates of the view are delegated to a [GameView] object
 * to inform the user about changing [RaumffischGame] states.
 */
class GameController {

  /**
   * Referencing the to be controlled model.
   */
  RaumffischGame game;

  /**
   * Referencing the presenting view.
   */
  final view = new GameView();

  /**
   * Periodic trigger controlling snake movement.
   */
  Timer updateTrigger;

  /**
   * Periodic trigger controlling mice movement.
   */
  Timer miceTrigger;
  
  MultiKeyController mkc;

  /**
   * Constructor to create a controller object.
   * Registers all necessary event handlers necessary
   * for the user to interact with a [RaumffischGame].
   */
  GameController() {

    // New game is started by user
    view.startButton.onClick.listen((_) {
      if (updateTrigger != null) updateTrigger.cancel();
      if (miceTrigger != null) miceTrigger.cancel();
      game = new RaumffischGame(gamesize);
      view.generateField(game);
      updateTrigger = new Timer.periodic(gameSpeed, (_) => _update());
      mkc=new MultiKeyController();
      AudioElement audio = querySelector('#audiop');
      audio.muted=false;
      audio.play();
      game.start();
      view.update(game);
    });

    // Steering of the snake
  
    window.onKeyDown.listen((KeyboardEvent ev) {
      
        
      
    });
  }



  /**
   * Moves the snake.
   */
  void _update() {
    if (game.gameOver) { game.stop(); view.update(game); return; }

    
    if (!game.stopped){
            
          
            //Ffisch nach links bewegen
            if(mkc.isPressed(KeyCode.LEFT))
              game.ffisch.moveleft();
            //Ffisch nach recht bewegen
            if(mkc.isPressed(KeyCode.RIGHT) )
              game.ffisch.moveright();
            //Ffisch nach oben bewegen
            if(mkc.isPressed(KeyCode.UP)   )
              game.ffisch.moveup();
            //Ffisch nach unten bewegen
            if(mkc.isPressed(KeyCode.DOWN)  )
              game.ffisch.movedown(); 
            //Feuern
            if(mkc.isPressed(KeyCode.SPACE) )
              game.ffisch.shoot();/**/ 
            //Spiel anhalten
            if(mkc.isPressed( KeyCode.PAUSE));/**/ 
           
            //PowerUp benutzen
            if(mkc.isPressed( KeyCode.ALT)); /**/ 
              
            
          }
    
    
    game.update();

    view.update(game);
  }


}
