part of raumffisch;

class EnemyGenerator extends Generator {
  
  List<Enemy> enemies = new List<Enemy>();
  
  EnemyGenerator(Level level, RaumffischGame game) :super(level, game){
    
  }
  void tick (int period){


    

    enemies.forEach((e){
      e.moveleft(); 
      if(e.detectCollisonWith(game.ffisch)){
         e.dead = true;
        game.ffisch.removelifes(1);
        }
      if(e.detectCollisonWith(game._protectlingGenerator.protectling)){
        game._protectlingGenerator.protectling.die();
        e.die();
      }
      List pi = game.ffisch.bullets.toList(); //trick for a deep copy so we can iterate and remove. 
                                              //Ordinary loop might be faster.
      pi.forEach((p){
        if(e.detectCollisonWith(p) && p.dead == false && e.dead ==false){
          e.take_damage(p._damage);
       
          game.ffisch.bullets.remove(p);             
        }
      if(p._position_x>=gamesize-p._sizex){
        p.die();
        game.ffisch.bullets.remove(p);
      }       
      }); 
        if(e._position_x<=0){
          e.die();                   
        }
     });
    if(_random.nextInt(_level._enemy_frequency)==0){
      bool founddead=false;
      for(var f in enemies){
        if(f.dead && !founddead){
          f.setposition(gamesize-f._sizex,_random.nextInt(gamesize-f._sizey));
          f.dead=false;
          founddead=true;
          break;
        }
      };
      
     if(!founddead){
        Enemy enemy = new Enemy(game);
        enemy.setposition(gamesize-enemy._sizex,_random.nextInt(gamesize-enemy._sizey));
        enemies.add(enemy);
      }
    }
  }
}