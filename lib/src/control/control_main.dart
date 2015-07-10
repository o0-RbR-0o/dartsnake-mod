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
  final GameView view = new GameView();
  
  AudioElement audio = querySelector('#audiop');
  
  int period = 0;

  /**
   * Periodic trigger controlling snake movement.
   */
  Timer updateTrigger;
  
  MultiKeyController mkc;

  GameController() {

    // New game is started by user
    view.intro_overlay.onClick.listen((_) {
      view.intro_overlay.style.setProperty('display', "none");
      if (updateTrigger != null) updateTrigger.cancel();
      game = new RaumffischGame(gamesize);
      view.generateField(game);
      updateTrigger = new Timer.periodic(gameSpeed, (_) => _update());
      mkc=new MultiKeyController();
      
      audio.muted=false;
      audio.play();
      audio.volume=0.4;
      game.start();
      //view.update(game);
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
        if(mkc.isPressed(KeyCode.SPACE) ){
          game.ffisch.shoot();/**/ 
        }
        else{
          game._ffisch._current_weapon.setShotFreqCount(0);
        }
        //Spiel anhalten
        if(mkc.isPressed( KeyCode.PAUSE));/**/ 
        //PowerUp benutzen
        if(mkc.isPressed( KeyCode.ALT)); /**/   
         
        game._ffisch.bullets.forEach((p){
          p.move();p.move();
        });
        
         
     }
    game.update(period);
    view.update(game);
    if(this.audio.currentTime>=59.8){
      this.audio.load();
      this.audio.currentTime=0;
      this.audio.play();
      
      this.audio.muted=false;
    }
  }
}
