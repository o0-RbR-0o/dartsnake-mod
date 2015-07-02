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