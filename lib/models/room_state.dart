import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotncold/models/player_entry.dart';

class RoomState {
  List<PlayerEntry> players = [];
  int readyCount = 0;

  RoomState(dynamic players, int readyCount);

  factory RoomState.fromJson(dynamic json) {
    var decodedJson = jsonDecode(json);

    List<dynamic> playersTmp = decodedJson['players'] as List;
    var ready = decodedJson['readyCount'] as int;

    return RoomState(playersTmp, ready);
  }
}
