import 'dart:convert';

import 'package:hotncold/models/game.dart';

class StartMessage {
  String type;
  Game game;

  StartMessage(this.type, this.game);

  factory StartMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return StartMessage(decoded['type'] as String, Game.fromJson(json['game']));
  }

  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}
