part of raumffisch;

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
  //Moves the Movable_Object left 1px;
  void moveleft(){
    if(this._position_x>0)
    this._position_x--;
  }
  
  //Moves the Movable_Object right 1px;
  void moveright(){
      if(this._position_x < (this._game._size-this._sizex))
      this._position_x++;
  }
  
  //Moves the Movable_Object up 1px;
  void moveup(){
    if(this._position_y>0)
      this._position_y--;
  }
  //Moves the Movable_Object down 1px;
  void movedown(){
    if(this._position_y < (this._game._size-_sizey))
      this._position_y++;
  }
  
  //Gets X-Position of the Movable_Object
  int getposition_x(){
    return this._position_x;
  }
  
  //Gets Y-Position of the Movable_Object
  int getposition_y(){
    return this._position_y;
  }
  
  //Sets X,Y-Position of the Movable_Object
  void setposition(int x,int y){
    this._position_x=x;
    this._position_y=y;
  }
  
  //Gets the length of the Movable_Object (For collision detection)
  int getsize_x(){
    return this._sizex;
  }
  
  //Gets the height of the Movable_Object (For collision detection)
  int getsize_y(){
      return this._sizey;
  }
  
}