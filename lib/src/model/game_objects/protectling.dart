part of raumffisch;

class Protectling extends Movable_Object{
  int _sizex = 1;
  int _sizey = 2;
  bool dead = false;
  int dir =1;
  
  Protectling(_game) : super(_game){
    unitname = "protectling";
  }
  
  move(int period){

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
    
    
    if(period % 2 == 0){
      this._position_y+=dir;
      if(_position_x < 2){
        this.dead = true;
        _game._score+=10;
      }
    }
  }
}