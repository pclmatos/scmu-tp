import 'dart:convert';

import 'package:hotncold/models/player_entry.dart';

class PlayerMessage {
  String type;
  PlayerEntry content;

  PlayerMessage(this.type, this.content);

  factory PlayerMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return PlayerMessage(
        decoded['type'] as String, PlayerEntry.fromJson(json['content']));
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
