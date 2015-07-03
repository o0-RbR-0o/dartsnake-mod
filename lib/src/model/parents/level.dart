part of raumffisch;
//A class for levels
class Level{
  int _powerup_frequency = 1;
  int _enemy_frequency = 1;
  int _length =1;
  
  Level(){
    
  }
  Level.fromVariables(int powerup_frequency, int enemy_frequency, length){
      this._powerup_frequency=powerup_frequency;
      this._enemy_frequency=enemy_frequency;
      this._length=length;
    }
  
  Level.fromJSONurl(String f){
     HttpRequest.getString(f).then(this.fromJSONstring);
  }
  
  void fromJSONstring(String s){
    print(s);
    Map jsonData=JSON.decode(s);
    this._powerup_frequency=jsonData['level']["powerup_frequency"];
    this._enemy_frequency=jsonData['level']["enemy_frequency"];
    this._length=jsonData['level']["length"];
  }
}