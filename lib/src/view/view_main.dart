part of raumffisch;

/**
 * A [GameView] object interacts with the DOM tree
 * to reflect actual [RaumffischGame] state to the user.
 */
class GameView {

  List<List<Element>> gamefield;
  
  /**
   * Element with id '#title' of the DOM tree.
   * Shown only if game is not running.
   */
  final title = querySelector("#title");

  /**
   * Element with id '#welcome' of the DOM tree.
   * Shown only if game is not running.
   */
  final HtmlElement welcome = querySelector("#welcome");
  final HtmlElement score = querySelector("#score");
  
  final HtmlElement intro_overlay = querySelector("#intro_overlay");
 

  /**
   * Element with id '#snakegame' of the DOM tree.
   * Used to visualize the field of a [RaumffischGame] as a HTML table.
   */
  final HtmlElement game = querySelector('#snakegame');

  
  final HtmlElement sbg = querySelector('#snakegame');
  final HtmlElement sbg2 = querySelector('#scrollbg');
  final HtmlElement mbg = querySelector('#main_background');
  /**
   * Element with id '#gameover' of the DOM tree.
   * Used to indicate that a game is over.
   */
  final gameover = querySelector('#gameover');
  
  final AudioElement soundShot1 = querySelector('#shotfire1');
  final AudioElement soundEnemyDie1 = querySelector('#enemydie1');
  final AudioElement soundPowerup1 = querySelector('#powerup1');
  
  /**
   * Element with id '#reasons' of the DOM tree.
   * Used to indicate why the game entered the game over state.
   */
  final reasons = querySelector('#reasons');

  /**
   * Element with id '#points' of the DOM tree.
   * Used to indicate how many points a user has actually collected.
   */
  final points = querySelector('#points');

  /**
   * Start button of the game.
   */
  HtmlElement get startButton => querySelector('#intro_overlay');
  
  int backgroundscroll=0,mainbackgroundscroll=0;

  void update(RaumffischGame model) {
    
    score.setInnerHtml(model._score.toString());
    
    welcome.style.display = model.stopped ? "block" : "none";

    reasons.innerHtml = "";

    
    //update background scrolling \o/
    this.backgroundscroll=(this.backgroundscroll+2)%(gamesize*8*2);
    this.mainbackgroundscroll++;
    
    this.sbg.style.backgroundPosition=(-this.backgroundscroll).toString()+"px 0";
    this.sbg2.style.backgroundPosition=(-this.backgroundscroll/2).toString()+"px 0";
    this.mbg.style.backgroundPosition=(-this.mainbackgroundscroll~/4).toString()+"px 0";
    
    if(model.eventSystem.shotfired){
      this.soundShot1.load();
      this.soundShot1.currentTime=0;
      this.soundShot1.play();
      this.soundShot1.muted=false;
      this.soundShot1.loop=false;
    }
    if(model.eventSystem.enemydied){
          this.soundEnemyDie1.load();
          this.soundEnemyDie1.currentTime=0;
          this.soundEnemyDie1.play();
          this.soundEnemyDie1.muted=false;
          this.soundEnemyDie1.loop=false;
        }
    if(model.eventSystem.powerupcollected){
          this.soundPowerup1.load();
          this.soundPowerup1.currentTime=0;
          this.soundPowerup1.play();
          this.soundPowerup1.muted=false;
          this.soundPowerup1.loop=false;
        }
    
    model.eventSystem.resetevents();
    
    //Spielobjekte aus dem Model auf das View-Grid zeichnen.
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