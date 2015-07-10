part of raumffisch;

/**
 * Defines a [RaumffischGame]. A [RaumffischGame] consists of n x n field.
 * On this field there moves a user controlled [Snake] of increasing length.
 * Aim of the [Snake] is to eat as many mice ([Mouse]) as possible.
 */
class RaumffischGame {


  List<Movable_Object> _objects = new List<Movable_Object>();
  Ffisch ffisch;
  Protectling protectling;
  int _score = 0;
  
  int period = 0;
  
  Level _level;
  
  EnemyGenerator _enemyGenerator;
  ProtectlingGenerator _protectlingGenerator;
  PowerupGenerator _powerupGenerator;
  // List of mice.

  EventSystem eventSystem=new EventSystem();

  var _protectlings = [];

  // The field size of the game (nxn field)
  final int _size;

  // The gamestate of the game (one of #running, #stopped).
  Symbol _gamestate;
  

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

  

  
  int lifes(){
    return ffisch._lifes;
  }

  /**
   * Constructor to create a new game with
   * - a centered snake heading up ([headUp])
   * - and one static random placed mouse on the field.
   */
  RaumffischGame(this._size) {
    start();
    
    _level = new Level.fromJSONurl("levels/level.json");

    ffisch = new Ffisch(this,new OneShot(this, 16));


    _enemyGenerator = new EnemyGenerator(_level, this);
    _protectlingGenerator = new ProtectlingGenerator(_level, this);
    _powerupGenerator = new PowerupGenerator(_level, this);
    _protectlingGenerator.protectling.setposition((gamesize-1)~/2, gamesize-1-_protectlingGenerator.protectling._sizey);
    stop();
  }
  

  

  /**
   * Returns whether the game is over.
   * Game is over, when snake has left the field or is tangled.
   */
  bool get gameOver => _gameOver;
  
  bool _gameOver = false;

  /**
   * Returns a list of mice.
   */
  List<Protectling> get protectlings => _protectlings;

  List<Movable_Object> get objects {
    
    _objects.clear();
    _objects.add(_protectlingGenerator.protectling);
    _objects.add(ffisch);
    _objects.addAll(_enemyGenerator.enemies);
    _objects.addAll(ffisch.bullets);
    _objects.addAll(_powerupGenerator._powerups);
   
    return _objects;
  }
  
  void applylevelUp(){
    _level.levelUp();
      
    
  }
  
  void update(int period) {
    this.period = period;
    if (running){
      if(period > _level._length){
        applylevelUp();
      }
      _enemyGenerator.tick(period);
      _protectlingGenerator.tick(period);
      _powerupGenerator.tick(period);
    }
    if(ffisch._lifes <=0){
      this._gameOver = true;
      
    }
  }
  int get size => _size;
  int get level => 1;

}