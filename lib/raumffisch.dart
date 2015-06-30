library raumffisch;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'dart:collection';

part 'src/model/parents/movable_object.dart';
part 'src/model/parents/generator.dart';

part 'src/model/game_objects/protectling.dart';
part 'src/model/game_objects/projectile.dart';
part 'src/model/game_objects/ffisch.dart';
part 'src/model/game_objects/enemy.dart';
part 'src/model/generators/enemy_generator.dart';
part 'src/model/generators/protectling_generator.dart';
part 'src/model/parents/level.dart';

part 'src/control/inputs/multikeycontroller.dart';

part 'src/model/model_main.dart';
part 'src/control/control_main.dart';
part 'src/view/view_main.dart';

const gamesize = 80;
const gameSpeed = const Duration(milliseconds: 20);
