import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';

class RoomState extends ChangeNotifier {
  List<PlayerEntry> players = [];
  int readyCount = 0;

  void updateRoom(dynamic json) {
    var decodedJson = jsonDecode(json);
    var playersTmp = decodedJson['players'] as List;

    players =
        playersTmp.map((player) => PlayerEntry.fromJson(playersTmp)).toList();
    readyCount = decodedJson['readyCount'];

    notifyListeners();
  }
}
