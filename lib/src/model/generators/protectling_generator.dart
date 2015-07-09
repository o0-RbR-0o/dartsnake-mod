part of raumffisch;

class ProtectlingGenerator extends Generator {
  

  
  ProtectlingGenerator(Level level, RaumffischGame game) :super(level, game){
    
  }
  void tick (int period){
    if(_game.protectling.dead == true){
      _game.protectling.setposition((gamesize-1)~/2, gamesize-1-_game.protectling._sizey);
      _game.protectling.dead = false;
    }
    _game.protectling.move(period);

  }
}