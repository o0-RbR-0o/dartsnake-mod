part of raumffisch;

class EnemyGenerator extends Generator {
  
  List<Enemy> _enemies = new List<Enemy>();
  
  EnemyGenerator(Level level, RaumffischGame game) :super(level, game){
    
  }
  void tick (int period){
    if(_game.protectling.dead == true){
      _game.protectling.setposition((gamesize-1)~/2, gamesize-1-_game.protectling._sizey);
      _game.protectling.dead = false;
    }
    _game.protectling.move(period);
    
    _enemies.forEach((e){
      e.moveleft(); 
    });
  
    _game._ffisch.projectiles.forEach((p){
      p.move();p.move();
    });
    if(_random.nextInt(_level._enemy_frequency)==0){
      bool founddead=false;
      _enemies.forEach((f){
        if(f.dead && !founddead){
          f.setposition(gamesize-f._sizex,_random.nextInt(gamesize-f._sizey));
          f.dead=false;
          founddead=true;
        }
      });
      if(!founddead){
        Enemy enemy = new Enemy(_game);
        enemy.setposition(gamesize-enemy._sizex,_random.nextInt(gamesize-enemy._sizey));
        _enemies.add(enemy);
      }
    }
    _enemies.forEach((e){
      if(e.detectCollisonWith(_game._ffisch) && !e.dead){
        _game._gameOver = true;}
      if(e.detectCollisonWith(_game.protectling) && !e.dead){
        _game.protectling.die();
    }
    List pi = _game._ffisch.projectiles.toList();
    pi.forEach((p){
      if(e.detectCollisonWith(p) && p.dead == false && e.dead ==false){
        e.die();
        _game._score+=1;
        _game._ffisch.projectiles.remove(p);             
      }
      if(p._position_x>=gamesize-1){
        p.die();
        _game._ffisch.projectiles.remove(p);
      }       
    }); 
    if(e._position_x<=0){
      e.die();                   
    }
   });       
  }
}