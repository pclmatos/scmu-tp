import 'package:flutter/widgets.dart';
import 'package:hotncold/models/game.dart';

class GameProvider extends ChangeNotifier {
  Game _state = Game([], 0, []);

  Game get state => _state;

  set state(Game newState) {
    _state = newState;

    notifyListeners();
  }
}
