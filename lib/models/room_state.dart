import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';

class RoomState extends ChangeNotifier {
  List<PlayerEntry> players = [];
  int readyCount = 0;

  RoomState(dynamic players, int readyCount);

  void updateRoom(dynamic json) {
    var decodedJson = jsonDecode(json);
    print(decodedJson);
    List<dynamic> playersTmp = decodedJson['content']['players'] as List;
    readyCount = decodedJson['content']['readyCount'] as int;

    for (var entry in playersTmp) {
      PlayerEntry pEntry = PlayerEntry.fromJson(entry);
      players.add(pEntry);
    }

    notifyListeners();
  }

  void reset() {
    players = [];
    readyCount = 0;

    notifyListeners();
  }

  factory RoomState.fromJson(dynamic json) {
    var decodedJson = jsonDecode(json);

    List<dynamic> playersTmp = decodedJson['players'] as List;
    var ready = decodedJson['readyCount'] as int;

    return RoomState(playersTmp, ready);
  }
}
