part of raumffisch;

class EnemyGenerator extends Generator {
  
  List<Enemy> _enemies = new List<Enemy>();
  
  EnemyGenerator(Level level, RaumffischGame game) :super(level, game){
    
  }
  void tick (int period){


    

    _enemies.forEach((e){
      e.moveleft(); 
      if(e.detectCollisonWith(_game._ffisch)){
         e.dead = true;
        _game._ffisch.removelifes(1);
        }
      if(e.detectCollisonWith(_game.protectling)){
        _game.protectling.die();
        e.die();
      }
      List pi = _game._ffisch.bullets.toList(); //trick for a deep copy so we can iterate and remove. 
                                              //Ordinary loop might be faster.
      pi.forEach((p){
        if(e.detectCollisonWith(p) && p.dead == false && e.dead ==false){
          e.take_damage(p._damage);
       
          _game._ffisch.bullets.remove(p);             
        }
      if(p._position_x>=gamesize-p._sizex){
        p.die();
        _game._ffisch.bullets.remove(p);
      }       
      }); 
        if(e._position_x<=0){
          e.die();                   
        }
     });
    if(_random.nextInt(_level._enemy_frequency)==0){
      bool founddead=false;
      for(var f in _enemies){
        if(f.dead && !founddead){
          f.setposition(gamesize-f._sizex,_random.nextInt(gamesize-f._sizey));
          f.dead=false;
          founddead=true;
          break;
        }
      };
      
     if(!founddead){
        Enemy enemy = new Enemy(_game);
        enemy.setposition(gamesize-enemy._sizex,_random.nextInt(gamesize-enemy._sizey));
        _enemies.add(enemy);
      }
    }
  }
}