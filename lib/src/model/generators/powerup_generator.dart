part of raumffisch;

class PowerupGenerator extends Generator {
  
   List<Powerup>  _powerups = new  List<Powerup>();
  
  PowerupGenerator(Level level, RaumffischGame game) :super(level, game){
     
  }
  void tick (int period){

    Powerup f;
    
    if(_random.nextInt(_level._powerup_frequency)==0){
      switch(_random.nextInt(4)){
        case 0:
          f= new OneShotPowerup(_game);
        break;
        case 1:
          f= new DoubleShotPowerup(_game);
        break;
        case 2:
          f = new DiagonalShotWithFrontPowerup(_game);
        break;
        case 3:
          f = new SineDoubleShotPowerup(_game);
        break;
        
      }
      
      f.setposition(gamesize-f._sizex,_random.nextInt(gamesize-f._sizey));
      _powerups.add(f);
      
    };

    _powerups.forEach((p){
      p.moveleft();
      if(p._position_x<=0){
        p.die();                   
      }
      
      if(p.detectCollisonWith(_game._ffisch)){
        p.apply(_game._ffisch);
        p.die();
      }
    });
      

  }
}