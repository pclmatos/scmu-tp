import 'package:flutter/widgets.dart';
import 'package:hotncold/models/room_state.dart';

class RoomStateProvider extends ChangeNotifier {
  RoomState _state = RoomState([], 0);

  RoomState get state => _state;

  set state(RoomState newState) {
    _state = newState;

    notifyListeners();
  }
}
