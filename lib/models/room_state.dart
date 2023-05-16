import 'package:hotncold/models/player_entry.dart';

class RoomState {
  List<PlayerEntry> players = [];
  int readyCount = 0;

  RoomState(this.players, this.readyCount);

  factory RoomState.fromJson(dynamic json) {
    List<dynamic> playersTmp = json['players'] as List;
    var ready = json['readyCount'] as int;

    List<PlayerEntry> tmp = [];
    for (var entry in playersTmp) {
      tmp.add(PlayerEntry.fromJson(entry));
    }

    return RoomState(tmp, ready);
  }

  String containsPlayer(String email) {
    String entry = '';
    for (var player in players) {
      if (player.email == email) {
        entry = player.state;
      }
    }

    return entry;
  }

  @override
  String toString() {
    return 'RoomState [players=$players , readyCount=$readyCount]';
  }
}
