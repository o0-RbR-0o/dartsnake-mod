part of raumffisch;
//Todo:
//Beim Refactoring Generics statt Vererbung nutzen.
//seed richtig holen
class Generator{
  RaumffischGame _game;
  Random _random = new Random(872739419772238);
  Level _level;
  Generator(Level level, RaumffischGame game){
    this._game = game;
    this._level = level;
  }
}