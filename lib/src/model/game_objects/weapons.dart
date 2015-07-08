part of raumffisch;

abstract class Weapon{  
  final RaumffischGame _game;
  int _sfreq_counter;
  int _shot_frequency;
  
  Weapon(this._game);
  List<Bullet> shoot();
  void setShotFreqCount(int s);
}

class StandardWeapon{
  final RaumffischGame _game;
   int _sfreq_counter=0;
   int _shot_frequency;
   
   StandardWeapon(this._game, this._shot_frequency);
   
   void setShotFreqCount(int s){
     this._sfreq_counter=s;
   }
}



class OneShot extends StandardWeapon implements Weapon{  
  OneShot(_game, _shot_frequency) : super(_game,_shot_frequency);
  
  List<Bullet> shoot(){
    List<Bullet> bl=new List<Bullet>();
    if(this._sfreq_counter==0){
      Bullet p = new Projectile(_game,1,0); 
      p.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2));
      bl.add(p);
    }
    this._sfreq_counter=(this._sfreq_counter+1)%this._shot_frequency;
    return bl;
  }
}

class DoubleShot extends StandardWeapon implements Weapon{  
  DoubleShot(_game, _shot_frequency) : super(_game,_shot_frequency);
  
  List<Bullet> shoot(){
    List<Bullet> bl=new List<Bullet>();
    if(this._sfreq_counter==0){
      Bullet p = new Projectile(_game,1,0); 
      
      p.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2)+1);
      
      bl.add(p);
    }
    else if(this._sfreq_counter==(this._shot_frequency/2)){
      Bullet p = new Projectile(_game,1,0);
            p.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2)-1);
            bl.add(p);
    }
    this._sfreq_counter=(this._sfreq_counter+1)%this._shot_frequency;
    return bl;
  }
}

class DiagonalShotWithFront extends StandardWeapon implements Weapon{  
  DiagonalShotWithFront(_game, _shot_frequency) : super(_game,_shot_frequency);
  
  List<Bullet> shoot(){
    List<Bullet> bl=new List<Bullet>();
    if(this._sfreq_counter==0){
      Bullet p = new Projectile(_game,1,1); 
      Bullet p2 = new Projectile(_game,1,-1);
      
      p2.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2)-1);
      p.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2)+1);
      
      bl.add(p);
      bl.add(p2);
    }
    if(this._sfreq_counter==0 || this._sfreq_counter==(this._shot_frequency/2)){
      Bullet p3 = new Bigprojectile(_game,1,0);
      p3.setposition(_game._ffisch._position_x+_game._ffisch._sizex-1, _game._ffisch._position_y+(_game._ffisch._sizey ~/2));
      bl.add(p3);
    }
    this._sfreq_counter=(this._sfreq_counter+1)%this._shot_frequency;
    return bl;
  }
}