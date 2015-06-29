part of dartsnake;

/**
 * A [SnakeView] object interacts with the DOM tree
 * to reflect actual [RaumffischGame] state to the user.
 */
class SnakeView {

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
  final welcome = querySelector("#welcome");
  final score = querySelector("#score");


  /**
   * Element with id '#snakegame' of the DOM tree.
   * Used to visualize the field of a [RaumffischGame] as a HTML table.
   */
  final game = querySelector('#snakegame');

  /**
   * Element with id '#gameover' of the DOM tree.
   * Used to indicate that a game is over.
   */
  final gameover = querySelector('#gameover');

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
  HtmlElement get startButton => querySelector('#start');
  
  

  /**
   * Updates the view according to the [model] state.
   *
   * - [startButton] is shown according to the stopped/running state of the [model].
   * - [points] are updated according to the [model] state.
   * - [gameover] is shown when [model] indicates game over state.
   * - Game over [reasons] ([model.snake] tangled or off field) are shown when [model] is in game over state.
   * - Field is shown according to actual field state of [model].
   */
  void update(RaumffischGame model) {
    
    score.setInnerHtml(model._score.toString());
    
    welcome.style.display = model.stopped ? "block" : "none";
    // title.style.display = model.stopped? "block" : "none";

    //points.innerHtml = "Points: ${model.miceCounter}";
    //gameover.innerHtml = model.gameOver ? "Game Over" : "";
    reasons.innerHtml = "";
    //if (model.gameOver) {
    //  final tangled = model.snake.tangled ? "Do not tangle your snake<br>" : "";
    //  final onfield = model.snake.notOnField ? "Keep your snake on the field<br>" : "";
    //  reasons.innerHtml = "$tangled$onfield";
    //}

    // Updates the field
    
    
    
    final field = model.field;
    for (int row = 0; row < field.length; row++) {
      for (int col = 0; col < field[row].length; col++) {
        
      
          gamefield[col][row].classes.clear();
          if (field[row][col]== #protectling) gamefield[col][row].classes.add('protectling');
          else if (field[row][col] == #ffisch) gamefield[col][row].classes.add('ffisch');
          else if (field[row][col] == #enemy) gamefield[col][row].classes.add('enemy');
          else if (field[row][col] == #projectile) gamefield[col][row].classes.add('projectile');
       
      }
      
    }
  }

  /**
   * Generates the field according to [model] state.
   * A HTML table (n x n) is generated and inserted
   * into the [game] element of the DOM tree.
   */
  void generateField(RaumffischGame model) {
    gamefield = new List<List<Element>>();
    final field = model.field;

    String table = "";
    for (int row = 0; row < field.length; row++) {
      table += "<tr>";
      for (int col = 0; col < field[row].length; col++) {
        final assignment = field[row][col];
        final pos = "field_${row}_${col}";
        table += "<td id='$pos' class='$assignment'></td>";
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