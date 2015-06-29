part of dartsnake;

/*----------------------------New stuff-----------------------------------------------------*/
//Todo:
//Beim Refactoring Generics statt Vererbung nutzen.
//seed richtig holen
class Generator{
  RaumffischGame _game;
  Random _random = new Random(872739419772238);
  Level _level;
  Generator(Level level, RaumffischGame game){
    this._game = game;
    this._level = level;
  }
}

class EnemyGenerator extends Generator {
  
  List<Enemy> _enemies = new List<Enemy>();
  
  EnemyGenerator(Level level, RaumffischGame game) :super(level, game){
    
  }
  void tick (){
    if(_game.protectling.dead == true){
      _game.protectling.setposition((gamesize-1)~/2, gamesize-1-_game.protectling._sizey);
      _game.protectling.dead = false;
    }
    _game.protectling.move();
    _enemies.forEach((e){
      
      e.moveleft();

      
    });
    _game._ffisch.projectiles.forEach((p){p.moveright();p.moveright();});
    if(_random.nextInt(_level.enemy_frequency)==0){
      
      
      bool founddead=false;
      _enemies.forEach((f){
        if(f.dead && !founddead){
          f.setposition(60,_random.nextInt(60));
          f.dead=false;
          founddead=true;
          
        }
      });
      if(!founddead){
        Enemy enemy = new Enemy(_game);
      
      enemy.setposition(60,_random.nextInt(60));
          _enemies.add(enemy);
      }
      
      
    }
    _enemies.forEach((e){
           if(e.detectCollisonWith(_game._ffisch) && !e.dead){
             _game._gameOver = true;}
           if(e.detectCollisonWith(_game.protectling)){
             _game.protectling.die();
           }
            List pi = _game._ffisch.projectiles.toList();
            pi.forEach((p){
             if(e.detectCollisonWith(p)){
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

class ProtectlingGenerator extends Generator {
  
  List<Protectling> enemies = new List<Protectling>();
   
  ProtectlingGenerator(Level level,game) :super(level, game){
     
   }
   
   
}



//A class for levels
class Level{
  int speed = 1;
  int enemy_frequency = 60;
  
  Level(){
    
  }
  
  void loadFromFile(String f){
    //File ff=new File(f);
    
  }
  
}

//A class for movable objects.
class Movable_Object{
  final RaumffischGame _game;
  int _position_x;
  int _position_y;
  int _sizex;
  int _sizey;
  bool dead = false;
  String unitname = "";
  
  Movable_Object(this._game){

  }
  
  void die(){
    this.dead = true;
  }
  
  //Detects collision with another Movable_Object with bounding boxes in size of the object. Returns true in case of collision.
  bool detectCollisonWith(Movable_Object o){
    return  ( this._position_x < o._position_x + o._sizex     &&
              this._position_x + this._sizex > o._position_x  &&
              this._position_y < o._position_y + o._sizey     &&
              this._sizey + this._position_y > o._position_y               
            );
  }
  //Moves the Ffisch left 1px;
  void moveleft(){
    if(this._position_x>0)
    this._position_x--;
  }
  
  //Moves the Ffisch right 1px;
  void moveright(){
      if(this._position_x < (this._game._size-this._sizex))
      this._position_x++;
  }
  
  //Moves the Ffisch up 1px;
  void moveup(){
    if(this._position_y>0)
      this._position_y--;
  }
  //Moves the Ffisch down 1px;
  void movedown(){
    if(this._position_y < (this._game._size-_sizey))
      this._position_y++;
  }
  
  //Gets X-Position of the Ffisch
  int getposition_x(){
    return this._position_x;
  }
  
  //Gets Y-Position of the Ffisch
  int getposition_y(){
    return this._position_y;
  }
  
  //Sets X,Y-Position of the Ffisch
  void setposition(int x,int y){
    this._position_x=x;
    this._position_y=y;
  }
  
  //Gets the length of the Ffisch (For collision detection)
  int getsize_x(){
    return this._sizex;
  }
  
  //Gets the height of the Ffisch (For collision detection)
  int getsize_y(){
      return this._sizey;
  }
  
}
//Class for projectiles extends Movable_Object. 
class Projectile extends Movable_Object{
  int _sizex = 1;
  int _sizey = 1;
  Projectile(_game) : super(_game){
    unitname = "projectile";
  }
  
}

class Enemy extends Movable_Object{
  int _sizex = 3;
  int _sizey = 3;
  Enemy(_game) : super(_game){
    unitname = "enemy";
  }
  
}

class Protectling extends Movable_Object{
  int _sizex = 1;
  int _sizey = 2;
  bool dead = false;
  int dir =1;
  
  Protectling(_game) : super(_game){
    unitname = "protectling";
  }
  
  move(){
    if( _position_y >0){
      
    if(_position_y==gamesize-_sizey-1){
      moveup();
      moveleft();
      moveleft();
      moveleft();
      dir=-1;
    }
    
    if(_position_y-_sizey == 0){
      movedown();
      moveleft();
      moveleft();
      moveleft();
      dir = 1;
    }
    
    }
    
    this._position_y+=dir;
    if(_position_x < 2){
      this.dead = true;
      _game._score+=10;
      
      
    }
     
  }
}

//Class for the player Ffisch extends Movable_Object. Would be cool to change positioning stuff to use vectors...
class Ffisch extends Movable_Object{
  int _powerups;
  int _lifes;
  int _sizex = 4;
  int _sizey = 3;
  List<Projectile> projectiles = new List<Projectile>();
  
  Ffisch(_game):super(_game){
    unitname = "ffisch";
    
    final s = _game.size;
     this._position_y =  s ~/2;
     this._position_x = 2;
  }
  
  //Adds "anzahl" lifes to the Ffisch
  void addlifes(int anzahl){
    this._lifes+=anzahl;
  }
  
  //Removes "anzahl" lifes from the Ffisch
  void removelifes(int anzahl){
    this._lifes-=anzahl;
  }
  
  //Sets the amount of lifes for the Ffisch
  void setlifes(int anzahl){
    this._lifes=anzahl;
  }
  
  //Adds "anzahl" powerups to the Ffisch
  void addpowerups(int anzahl){
    this._powerups+=anzahl;
  }
  
  //Removes "anzahl" powerups from the Ffisch
  void removepowerups(int anzahl){
    this._powerups-=anzahl;
  }
  
  //Sets the amounts of powerups for the Ffisch
  void setpowerups(int anzahl){
    this._powerups=anzahl;
  }
  
  void shoot(){
    var p = new Projectile(_game);
    p.setposition(this._position_x+_sizex-1, this._position_y+(this._sizey ~/2));
    projectiles.add(p);
  }
}
  




/**
 * Defines a [RaumffischGame]. A [RaumffischGame] consists of n x n field.
 * On this field there moves a user controlled [Snake] of increasing length.
 * Aim of the [Snake] is to eat as many mice ([Mouse]) as possible.
 */
class RaumffischGame {

  // The snake of the game.

  Ffisch _ffisch;
  Protectling protectling;
  int _score = 0;
  
  EnemyGenerator _enemyGenerator;

  // List of mice.

  

  var _protectlings = [];

  // The field size of the game (nxn field)
  final int _size;

  // The gamestate of the game (one of #running, #stopped).
  Symbol _gamestate;

  int get miceCounter => 1;
  /**
   * Indicates whether game is stopped.
   */
  bool get stopped => _gamestate == #stopped;

  /**
   * Indicates whether game is running.
   */
  bool get running => _gamestate == #running;

  /**
   * Starts the game.
   */
  void start() { _gamestate = #running; }

  /**
   * Stops the game.
   */
  void stop() { _gamestate = #stopped; }

  /**
   * Constructor to create a new game with
   * - a centered snake heading up ([headUp])
   * - and one static random placed mouse on the field.
   */
  RaumffischGame(this._size) {
    start();

    _ffisch = new Ffisch(this);
    protectling = new Protectling(this);
    protectling.setposition((gamesize-1)~/2, gamesize-1-protectling._sizey);
    _enemyGenerator = new EnemyGenerator(new Level(), this);
    stop();
  }

  /**
   * Returns whether the game is over.
   * Game is over, when snake has left the field or is tangled.
   */
  bool get gameOver => _gameOver;
  
  bool _gameOver = false;
  /**
   * Returns the snake.
   */
  Ffisch get ffisch => _ffisch;

  /**
   * Returns a list of mice.
   */
  List<Protectling> get protectlings => _protectlings;

  /**
   * Returns the game field as a list of lists.
   * Each element of the field has exactly one out of three valid states (Symbols).
   * #empty, #mouse or #snake
   */
  List<List<Symbol>> get field {

    var _field = new Iterable.generate(_size, (row) {
      return new Iterable.generate(_size, (col) => #empty).toList();
    }).toList();
    protectlings.forEach((p){
        for(int i=0;i<p._sizey;i++){
          for(int j=0;j<p._sizex;j++){
            _field[p._position_y+i][p._position_x+j] = #protectling;
          }
        }      
    });
    
    _enemyGenerator._enemies.forEach((p){
        if(p.dead == false){
          for(int i=0;i<p._sizey;i++){
            for(int j=0;j<p._sizex;j++){
              _field[p._position_y+i][p._position_x+j] = #enemy;
            }
          }
        }
    });
   
    
    for(int i=0;i<ffisch._sizey;i++){
      for(int j=0;j<ffisch._sizex;j++){
        _field[ffisch._position_y+i][ffisch._position_x+j] = #ffisch;
      }
    }
    
    for(int i=0;i<protectling._sizey;i++){
      for(int j=0;j<protectling._sizex;j++){
        _field[protectling._position_y+i][protectling._position_x+j] = #protectling;
      }
    }
    
    _ffisch.projectiles.forEach((p){
        for(int i=0;i<p._sizey;i++){
          for(int j=0;j<p._sizex;j++){
            _field[p._position_y+i][p._position_x+j] = #projectile;
          }
        }      
    });
    return _field;
  }

  List<Movable_Object> get objects {
    List<Movable_Object> objects = new List<Movable_Object>();
    objects.add(protectling);
    objects.add(_ffisch);
    objects.addAll(_enemyGenerator._enemies);
    objects.addAll(_ffisch.projectiles);
    return objects;
  }
  


  /**
   * Moves the snake according to its internal [headUp], [headDown], [headLeft],
   * [headRight] state.
   * Operation is only executed if game state is [running].
   */
  void update() {
    if (running){
      _enemyGenerator.tick();
    }
  
  
  }

  /**
   * Moves each [Mouse] of the mice list according to their internal
   * movement direction.
   * Operation is only executed if game state is [running].
   */

  /**
   * Adds a new [Mouse] to the game.
   * Operation is not executed if game state is [stopped].
   
  void addMouse() {
    if (stopped) return;
    Random r = new Random();
    final row = r.nextInt(_size);
    final col = r.nextInt(_size);
    _mice.add(new Mouse.staticOn(this, row, col));
  }
*/
  /**
   * Returns the size of the game. The game is played on a nxn-field.
   */
  int get size => _size;

  /**
   * Returns the actual level of the game.
   * Right now this is constant level 1. But further levels
   * might be added in future versions of the game.
   */
  int get level => 1;

  /**
   * Returns a textual representation of the game state.
   */
  String toString() => field.map((row) => row.join(" ")).join("\n");
}