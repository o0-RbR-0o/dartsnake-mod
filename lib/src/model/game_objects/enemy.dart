part of raumffisch;

abstract class Damage_taker{
  int _life;
  
  void take_damage(int damage){
    this._life = this._life - damage;
  }
}


class Enemy extends Movable_Object with Damage_taker{
  int _sizex = 3;
  int _sizey = 3;
  int _life = 5;
  Enemy(_game) : super(_game){
    unitname = "enemy";
   
  }
  
  void take_damage(int damage){
    super.take_damage(damage);
    if(_life <= 0){
      _game._score+=1;
      die();
      
    }
  }
  

  
  
}