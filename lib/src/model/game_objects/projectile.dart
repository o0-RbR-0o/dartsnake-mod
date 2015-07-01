part of raumffisch;

//Abstract class Bullet to define an interface for bullet objects.
abstract class Bullet extends Movable_Object{
  int _sizex;
  int _sizey;
  int _damage;
  int _stability;
  int _shot_frequency;
  Bullet(_game) : super(_game);      
  void move();
}

//Class for projectiles extends Movable_Object. 
class Projectile extends Movable_Object implements Bullet{
  int _sizex = 1;
  int _sizey = 1;
  int _damage=1;
  int _stability=1;
  int _shot_frequency=8;
  
  Projectile(_game) : super(_game){
    unitname = "projectile";
  }
  void move(){
    this.moveright();
  }
  
}

