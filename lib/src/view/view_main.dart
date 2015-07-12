part of raumffisch;

/**
 * A [GameView] object interacts with the DOM tree
 * to reflect actual [RaumffischGame] state to the user.
 */
class GameView {

  List<List<Element>> gamefield;
  final bool sound_on=true;
  //This will show the players score
  final HtmlElement score = querySelector("#score");  
  
  //introvoerlay for the welcomescreen
  final HtmlElement intro_overlay = querySelector("#intro_overlay");
 

  /**
   * Element with id '#snakegame' of the DOM tree.
   * Used to visualize the field of a [RaumffischGame] as a HTML table.
   */
  final HtmlElement game = querySelector('#snakegame');
  
  /**
   * Element to display ffischlifes
   * 
   */
  final HtmlElement lifesdisplay = querySelector('#ffischlifes');
  final HtmlElement distancedisplay = querySelector('#distance');

  
  final HtmlElement sbg = querySelector('#snakegame');
  final HtmlElement sbg2 = querySelector('#scrollbg');
  final HtmlElement mbg = querySelector('#main_background');
  /**
   * Element with id '#gameover' of the DOM tree.
   * Used to indicate that a game is over.
   */
  final gameover = querySelector('#gameover');
  
  final Element message = querySelector('#message');
  
  stxl.ResourceManager resMng=new stxl.ResourceManager();

  /**
   * Start button of the game.
   */
  HtmlElement get startButton => querySelector('#intro_overlay');
  
  //cyclecounters for parrallaxscrolling
  int backgroundscroll=0,mainbackgroundscroll=0;

  void loadSounds(){
    
    resMng.addSound("shot1", "audio/laser.wav");
    resMng.addSound("shot2", "audio/laser2.wav");
    resMng.addSound("shot3", "audio/laser3.wav");
    resMng.addSound("powerup1", "audio/powerup1.wav");
    resMng.addSound("enemydie1", "audio/enemydie1.wav");
    resMng.load();
    
  }
  
  //updates the DOM according to the model
  void update(RaumffischGame model) {
    
    score.setInnerHtml(model._score.toString());
    
    //welcome.style.display = model.stopped ? "block" : "none";
    //Display gameover message
    if(model._gameOver){
    message.innerHtml = "You've died. Your score: "+ model._score.toString();
      
  }


    
    //update background scrolling \o/
    this.backgroundscroll=(this.backgroundscroll+2)%(gamesize*8*2);
    this.mainbackgroundscroll++;
    
    this.sbg.style.backgroundPosition=(-this.backgroundscroll).toString()+"px 0";
    this.sbg2.style.backgroundPosition=(-this.backgroundscroll/2).toString()+"px 0";
    this.mbg.style.backgroundPosition=(-this.mainbackgroundscroll~/4).toString()+"px 0";
    
    if(sound_on){
      if(model.eventSystem.startmusic){     
                        stxl.AudioElementSound.load("audio/rbr_gamemusic1.ogg").then((stxl.Sound sound){sound.play(true,new stxl.SoundTransform(0.5));});
      }
      if(model.eventSystem.shotfired){
        var sound = this.resMng.getSound("shot1");
        sound.play(false);
      }
      if(model.eventSystem.shot2fired){
        var sound = this.resMng.getSound("shot2");
                sound.play(false);
      }
      if(model.eventSystem.shot3fired){
        var sound = this.resMng.getSound("shot3");
                sound.play(false);
      }
      if(model.eventSystem.enemydied){
        var sound = this.resMng.getSound("enemydie1");
                sound.play(false);
      }
      if(model.eventSystem.powerupcollected){
        var sound = this.resMng.getSound("powerup1");
                sound.play(false);
      }

    }
        
         
    model.eventSystem.resetevents();
    
    this.lifesdisplay.style.width = (model.lifes()*64).toString()+"px";
    this.distancedisplay.style.width = ((model.period / model._level._length)*100).toString()+"%";
    
    
    //Draws on the gamefiels accroding to model
    gamefield.forEach((f){f.forEach((td){td.classes.clear();});});
    model.objects.forEach(
      (o){
        if(!o.dead){
          for(int i = 0;i<o._sizex;i++){
            for(int j = 0;j<o._sizey;j++){
              gamefield[o._position_x+i][o._position_y+j].classes.add(o.unitname+i.toString()+j.toString());                  
            }      
          }
        }
      }
    );
    
  }

  /**
   * Generates the field according to [model] state.
   * A HTML table (n x n) is generated and inserted
   * into the [game] element of the DOM tree.
   */
  void generateField(RaumffischGame model) {
    gamefield = new List<List<Element>>();
    
    
   

    String table = "";
    for (int row = 0; row < gamesize; row++) {
      table += "<tr>";
      for (int col = 0; col < gamesize; col++) {
        final pos = "field_${row}_${col}";
        table += "<td id='$pos'></td>";
      }
      table += "</tr>";
    }

    //print(gamefield);
    game.innerHtml = table;
    for(int i = 0; i <gamesize;i++){
      gamefield.add(new List<Element>());
      for(int j= 0; j < gamesize; j++){
        gamefield[i].add(game.querySelector("#field_${j}_${i}"));  
        
      }
    }
  }
}