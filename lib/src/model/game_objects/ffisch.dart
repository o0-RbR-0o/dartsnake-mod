part of raumffisch;

//Class for the player Ffisch extends Movable_Object. Would be cool to change positioning stuff to use vectors...
class Ffisch extends Movable_Object{
  int _powerups;
  int _lifes;
  int _sizex = 4;
  int _sizey = 3;
  int _sfreq_counter=0;
  List<Bullet> projectiles = new List<Bullet>();
  
  Ffisch(_game):super(_game){
    unitname = "ffisch";
    
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
  
  void shoot(){
    Bullet p = new Projectile(_game);
    
    p.setposition(this._position_x+_sizex-1, this._position_y+(this._sizey ~/2));
   
    this._sfreq_counter=(this._sfreq_counter+1)%p._shot_frequency;
    
    if(this._sfreq_counter==0){
     projectiles.add(p);
    }
  }
}