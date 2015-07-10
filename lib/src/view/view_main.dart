part of raumffisch;

/**
 * A [GameView] object interacts with the DOM tree
 * to reflect actual [RaumffischGame] state to the user.
 */
class GameView {

  List<List<Element>> gamefield;
  
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
  
  final AudioElement soundShot1 = querySelector('#shotfire1');
  final AudioElement soundShot2 = querySelector('#shotfire2');
  final AudioElement soundShot3 = querySelector('#shotfire3');
  final AudioElement soundEnemyDie1 = querySelector('#enemydie1');
  final AudioElement soundPowerup1 = querySelector('#powerup1');
  final AudioElement audio = querySelector('#audiop');
  //messagebox for the gameover message
  final Element message = querySelector('#message');

  /**
   * Start button of the game.
   */
  HtmlElement get startButton => querySelector('#intro_overlay');
  
  //cyclecounters for parrallaxscrolling
  int backgroundscroll=0,mainbackgroundscroll=0;

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
    
    if(model.eventSystem.startmusic){
      audio.load();      
      audio.muted=false;
            audio.play();
            audio.volume=0.4;
    }
    if(model.eventSystem.shotfired){
      this.soundShot1.load();
      //this.soundShot1.currentTime=0;
      this.soundShot1.play();
      this.soundShot1.muted=false;
      this.soundShot1.loop=false;
    }
    if(model.eventSystem.shot2fired){
          this.soundShot2.load();
          //this.soundShot2.currentTime=0;
          this.soundShot2.play();
          this.soundShot2.muted=false;
          this.soundShot2.loop=false;
        }
    if(model.eventSystem.shot3fired){
             this.soundShot3.load();
             //this.soundShot3.currentTime=0;
             this.soundShot3.play();
             this.soundShot3.muted=false;
             this.soundShot3.loop=false;
           }
    if(model.eventSystem.enemydied){
          this.soundEnemyDie1.load();
          //this.soundEnemyDie1.currentTime=0;
          this.soundEnemyDie1.play();
          this.soundEnemyDie1.muted=false;
          this.soundEnemyDie1.loop=false;
        }
    if(model.eventSystem.powerupcollected){
          this.soundPowerup1.load();
          // this.soundPowerup1.currentTime=0;
          this.soundPowerup1.play();
          this.soundPowerup1.muted=false;
          this.soundPowerup1.loop=false;
        }
    if(this.audio.currentTime>=59.8){
          this.audio.load();
          this.audio.play();
          this.audio.muted=false;
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