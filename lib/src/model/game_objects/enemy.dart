part of raumffisch;

//class to make movable_objects damageable
abstract class Damage_taker{
  int _life;
  //applies damage
  void take_damage(int damage){
    this._life = this._life - damage;
  }
}

//Represents an enemy
class Enemy extends Movable_Object with Damage_taker{
  int _sizex = 8;
  int _sizey = 4;
  int _life = 7;
  Enemy(_game) : super(_game){
    unitname = "enemykraken";
   
  }
  
  void die(){
    super.die();
    _game.eventSystem.enemydied=true; //for sounds n stuff
  }
  
  void take_damage(int damage){
    super.take_damage(damage);
    if(_life <= 0){
      _game._score+=1;
      die();
      
      
    }
  }
  

  
  
}