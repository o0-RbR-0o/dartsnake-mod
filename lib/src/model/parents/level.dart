part of raumffisch;
//A class for levels
class Level{
  int _powerup_frequency = 1;
  int _enemy_frequency = 1;
  int _length =1;
  int _level = 0;
  var jsonData = null;
  bool levelLoaded=false;
  
  
  
  Level(){
    
  }
  Level.fromVariables(int powerup_frequency, int enemy_frequency, length){
      this._powerup_frequency=powerup_frequency;
      this._enemy_frequency=enemy_frequency;
      this._length=length;
  }
  

  void loaded(var s){
    levelLoaded = true;
  }
  
  

  Level.fromJSONurl(String f){
     HttpRequest.getString(f).then(this.fromJSONstring);
     
     
     print(jsonData.toString());
  }
  
  
  
  void fromJSONstring(String s){
    
    while(jsonData == null); //dirty, we know...
    JSON.decode(s).then(this.jsonData);
    

  }

  
  bool levelUp(){
    this._level++;
    return level(_level);
  }
  bool level(int i){
    if(jsonData == null || jsonData[i] == null){
      return false;
    }else{

      this._powerup_frequency=jsonData[i]['level']["powerup_frequency"];
      this._enemy_frequency=jsonData[i]['level']["enemy_frequency"];
      this._length=jsonData[i]['level']["length"];
      return true;
    }
    
  }
}