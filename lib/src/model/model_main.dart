part of raumffisch;

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
  
  int period = 0;
  
  EnemyGenerator _enemyGenerator;
  ProtectlingGenerator _protectlingGenerator;
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

    _ffisch = new Ffisch(this,new DiagonalShotWithFront(this,16));
    protectling = new Protectling(this);
    protectling.setposition((gamesize-1)~/2, gamesize-1-protectling._sizey);
    _enemyGenerator = new EnemyGenerator(new Level.fromJSONurl("levels/level1.json"), this);
    _protectlingGenerator = new ProtectlingGenerator(new Level.fromJSONurl("levels/level1.json"), this);
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
    return _field;
  }

  List<Movable_Object> get objects {
    List<Movable_Object> objects = new List<Movable_Object>(_enemyGenerator._enemies.length+_ffisch.bullets.length+2);
    print(objects.length);
    objects[0]=protectling;
    objects[1]=_ffisch;
    objects.setAll(2,_enemyGenerator._enemies);
    objects.setAll(_enemyGenerator._enemies.length+2,_ffisch.bullets);
    return objects;
  }
  
  void update(int period) {
    this.period = period;
    if (running){
      _enemyGenerator.tick(period);
      _protectlingGenerator.tick(period);
    }
  }
  int get size => _size;

  int get level => 1;

  /**
   * Returns a textual representation of the game state.
   */
  String toString() => field.map((row) => row.join(" ")).join("\n");
}