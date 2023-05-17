import 'dart:convert';

import 'package:hotncold/models/game.dart';

class StartMessage {
  String type;
  Game game;

  StartMessage(this.type, this.game);

  factory StartMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return StartMessage(decoded['type'], Game.fromJson(decoded['game']));
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'game': game};
  }
}
