part of dartsnake;

/*----------------------------New stuff-----------------------------------------------------*/

//A class for movable objects.
class Movable_Object{
  final RaumffischGame _game;
  int _position_x;
  int _position_y;
  int _sizex;
  int _sizey;
  
  Movable_Object.on(this._game){

  }
  
  //Detects collision with another Movable_Object. Todo: Changes positions to bounding boxes.
  bool detectCollisonWith(Movable_Object o){
    bool xcol=false, ycol=false;
    if(this._position_x == o._position_x){
      xcol=true;
    }
    if(this._position_y == o._position_y){
      ycol=true;
    }
    return xcol&&ycol;
  }
  
  //Moves the Ffisch left 1px;
  void moveleft(){
    this._position_x--;
  }
  
  //Moves the Ffisch right 1px;
  void moveright(){
      this._position_x++;
  }
  
  //Moves the Ffisch up 1px;
  void moveup(){
      this._position_y--;
  }
  //Moves the Ffisch down 1px;
  void movedown(){
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
  Projectile.on() : super.on(super._game){

  }
  
}

class Enemy extends Movable_Object{
  int _sizex = 3;
  int _sizey = 3;
  Enemy.on() : super.on(super._game){
    
  }
}

class Protectling extends Movable_Object{
  int _sizex = 2;
  int _sizey = 1;
  Protectling.on() : super.on(super._game){
    
  }
}

//Class for the player Ffisch extends Movable_Object. Would be cool to change positioning stuff to use vectors...
class Ffisch extends Movable_Object{
  int _powerups;
  int _lifes;
  int _sizex = 3;
  int _sizey = 2;
  Ffisch.on(_game):super.on(_game){
    
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
}
  

/*------------------------End new stuff-----------------------------------------------------*/

/**
 * Defines a [Snake] of the [RaumffischGame].
 * A [Snake] has a body (a list of continous body elements).
 * Each body element has a position (row, column) on the [RaumffischGame] field.
 * A [Snake] has a movement direction (up, down, left, right).
 */
class Snake {

  /**
   * References the game.
   */
  final RaumffischGame _game;

  /**
   * List of body elements of this snake.
   */
  var _body = [];

  /**
   * Actual vertical row movement of this snake. Can be -1, 0, 1.
   */
  int _dr;

  /**
   * Horizontal vertical column movement of this snake. Can be -1, 0, 1.
   */
  int _dc;

  /**
   * Constructor to create a [Snake] object for a [RaumffischGame].
   * Created snake has a body of two elements length.
   * Snake is positioned in the middle of [RaumffischGame] field.
   * Snake is created with upward movement.
   */
  Snake(this._game) {
    final s = _game.size;
    _body = [
      { 'row' : s ~/ 2,     'col' : s ~/ 2 },
      { 'row' : s ~/ 2 + 1, 'col' : s ~/ 2 }
    ];
    headUp();
  }

  /**
   * Moves the snake according to the movement status (up, down, left, right)
   * of this snake.
   * A [Snake] may eat a [Mouse] while this operation
   * if a [Mouse] object is on the field
   * a snake is moving on. In this case the [Mouse] will be eaten (removed from [RaumffischGame] state).
   * If there are more than one [Mouse] on this field only the first
   * [Mouse] will be eaten by the [Snake].
   * If a [Snake] eats a [Mouse] this snake gets one body element longer.
   * If a [Mouse] is eaten by this [Snake] a new [Mouse] with random position is generated.
   */
  void move() {

    final newrow = head['row'] + _dr;
    final newcol = head['col'] + _dc;



    _body.insert(0, { 'row' : newrow, 'col' : newcol });


  }

  /**
   * Tells this snake to move upward for following [move]s.
   */
  void headUp()    { _dr = -1; _dc =  0; }

  /**
   * Tells this snake to move downward for following [move]s.
   */
  void headDown()  { _dr =  1; _dc =  0; }

  /**
   * Tells this snake to move left for following [move]s.
   */
  void headLeft()  { _dr =  0; _dc = -1; }

  /**
   * Tells this snake to move right for following [move]s.
   */
  void headRight() { _dr =  0; _dc =  1; }

  /**
   * Indicates whether this snake is tangled.
   * A snake is tangled when two or more body elements of a snake share the
   * same position on the field.
   */
  bool get tangled {
    final tangledcheck = _body.map((s) => "${s['row']},${s['col']}").toSet();
    return tangledcheck.length != length;
  }

  /**
   * Indicates whether this snake is on field.
   */
  bool get onField {
    return head['row'] >= 0 &&
           head['row'] < _game.size &&
           head['col'] >= 0 &&
           head['col'] < _game.size;
  }

  /**
   * Indicates wether this snake is not on the field.
   */
  bool get notOnField => !onField;

  /**
   * Returns the length of this snake (amount of body elements).
   */
  int get length => _body.length;

  /**
   * Returns the head of this snake (first element of body elements).
   */
  Map get head => _body.first;

  /**
   * Returns the tail of this snake (last element of body elements).
   */
  Map get tail => _body.last;

  /**
   * Returns the body of this snake as a list of body element position mappings.
   */
  List<Map<String, int>> get body => _body;
}

/**
 * Defines a [Mouse] of the [RaumffischGame].
 * A [Mouse] has a position (row, column) on the [RaumffischGame] field.
 * And a [Mouse] might have a movement direction.
 */
class Mouse {

  // Reference to a [SnakeGame].
  final RaumffischGame _game;

  // Row position of this mouse.
  int _row;

  // Column position of this mouse.
  int _col;

  // Row direction of this mouse (might be -1, 0, +1)
  int _dr;

  // Column direction of this mouse (might be -1, 0, +1)
  int _dc;

  /**
   *  Constructor to create a non moving mouse for a [RaumffischGame].
   */
  Mouse.staticOn(this._game, this._row, this._col) {
    _dr = 0;
    _dc = 0;
  }

  /**
   * Constructor to create a random moving mouse for a [RaumffischGame].
   */
  Mouse.movingOn(this._game, this._row, this._col) {
    final r = new Random();
    _dr = -1 + r.nextInt(2);
    _dc = -1 + r.nextInt(2);
  }

  /**
   * Returns the actual row of this mouse.
   */
  int get row => _row;

  /**
   * Returns the actual column of this mouse.
   */
  int get col => _col;

  /**
   * Returns the actual position of this mouse as a map with keys 'row' and 'col'.
   */
  Map<String, int> get pos => {'row' : _row, 'col' : _col };

  /**
   * Moves this mouse
   */
  void move() {
    if (_dr < 0 && row == 0) _dr *= -1;
    if (_dc < 0 && col == 0) _dc *= -1;
    if (_dr > 0 && row == _game.size - 1) _dr *= -1;
    if (_dc > 0 && col == _game.size - 1) _dr *= -1;
    _row += _dr;
    _col += _dc;
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

  // List of mice.

  
  var _enemies = [];
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

    _ffisch = new Ffisch.on(this);
    stop();
  }

  /**
   * Returns whether the game is over.
   * Game is over, when snake has left the field or is tangled.
   */
  bool get gameOver => false;

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
        for(int i=0;i<p._sizex;i++){
          for(int j=0;j<p._sizey;j++){
            _field[p._position_x+i][p._position_y+j] = #protectling;
          }
        }      
    });
   
    
    for(int i=0;i<ffisch._sizex;i++){
      for(int j=0;j<ffisch._sizey;j++){
        _field[ffisch._position_x+i][ffisch._position_y+j] = #ffisch;
      }
    }
    return _field;
  }




  /**
   * Moves the snake according to its internal [headUp], [headDown], [headLeft],
   * [headRight] state.
   * Operation is only executed if game state is [running].
   */
  void moveSnake() { if (running); }

  /**
   * Moves each [Mouse] of the mice list according to their internal
   * movement direction.
   * Operation is only executed if game state is [running].
   */
  void moveMice() {/* if (running) mice.forEach((m) => m.move()); */ }

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