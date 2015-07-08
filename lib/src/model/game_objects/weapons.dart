part of raumffisch;

abstract class Weapon{  
  final RaumffischGame _game;
  int _sfreq_counter;
  int _shot_frequency;
  
  Weapon(this._game);
  List<Bullet> shoot();
}

class StandardWeapon implements Weapon{
  final RaumffischGame _game;
  int _sfreq_counter=0;
  int _shot_frequency;
  
  StandardWeapon(this._game, this._shot_frequency);
  
  List<Bullet> shoot(){
    List<Bullet> bl=new List<Bullet>();
    if(this._sfreq_counter==0){
      Bullet p = new Projectile(_game); 
      p.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2));
      bl.add(p);
    }
    this._sfreq_counter=(this._sfreq_counter+1)%this._shot_frequency;
    return bl;
  }
}