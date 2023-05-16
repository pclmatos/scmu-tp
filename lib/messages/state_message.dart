import 'dart:convert';

import 'package:hotncold/models/room_state.dart';

class StateMessage {
  String type;
  RoomState content;

  StateMessage(this.type, this.content);

  factory StateMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);
    print(decoded);

    return StateMessage(
        decoded['type'] as String, RoomState.fromJson(decoded['content']));
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
