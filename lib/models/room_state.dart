import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';

class RoomState extends ChangeNotifier {
  List<PlayerEntry> players = [];
  int readyCount = 0;

  void updateRoom(dynamic json) {
    var decodedJson = jsonDecode(json);
    List<dynamic> playersTmp = decodedJson['players'] as List;
    readyCount = decodedJson['readyCount'] as int;

    for (var entry in playersTmp) {
      players.add(PlayerEntry.fromJson(entry));
    }

    notifyListeners();
  }
}
