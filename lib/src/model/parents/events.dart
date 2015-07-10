part of raumffisch;

class EventSystem{
  bool fishdied=false;
  bool shotfired=false;
  bool enemydied=false;
  bool powerupcollected=false;
  bool protectlingsave=false;
  EventSystem();
  
  resetevents(){
    this.fishdied=false;
    this.shotfired=false;
    this.enemydied=false;
    this.powerupcollected=false;
    this.protectlingsave=false;
  }
}