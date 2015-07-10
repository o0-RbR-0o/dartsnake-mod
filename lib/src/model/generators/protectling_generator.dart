part of raumffisch;

class ProtectlingGenerator extends Generator {
  

  
  ProtectlingGenerator(Level level, RaumffischGame game) :super(level, game){
    
  }
  void tick (int period){
    if(_game.protectling.dead == true){
      _game.protectling.setposition((gamesize-1)~/2, gamesize-1-_game.protectling._sizey);
      _game.protectling.dead = false;
    }
    
    _game._ffisch.bullets.forEach((b){
      if(b.detectCollisonWith(_game.protectling)){
         _game.protectling.die();
         _game._score -10;
      }
    });
    _game.protectling.move(period);

  }
}