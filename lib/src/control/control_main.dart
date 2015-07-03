part of raumffisch;

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
  
  
  int period = 0;

  /**
   * Periodic trigger controlling snake movement.
   */
  Timer updateTrigger;
  
  MultiKeyController mkc;

  GameController() {

    // New game is started by user
    view.startButton.onClick.listen((_) {
      if (updateTrigger != null) updateTrigger.cancel();
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

    // Getting inputs:
    window.onKeyDown.listen((KeyboardEvent ev) {
    });
  }

  //Update pressed keys and tell model what to do.
  void _update() {
    period++;
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
    game.update(period);
    view.update(game);
  }
}
