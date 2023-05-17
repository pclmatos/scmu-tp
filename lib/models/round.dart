import 'package:hotncold/models/player_entry.dart';

class Round {
  List<PlayerEntry> seekers = [];
  final PlayerEntry hider;
  final double latitude;
  final double longitude;

  Round(this.hider, this.seekers, this.latitude, this.longitude);

  factory Round.fromJson(dynamic json) {
    List<dynamic> playersTmp = json['seekers'] as List;

    List<PlayerEntry> tmp = [];
    for (var entry in playersTmp) {
      tmp.add(PlayerEntry.fromJson(entry));
    }

    return Round(PlayerEntry.fromJson(json['hider']), tmp,
        json['latitude'] as double, json['longitude'] as double);
  }

  Map<String, dynamic> toJson() {
    return {
      'seekers': seekers,
      'hider': hider,
      'latitude': latitude,
      'longitude': longitude
    };
  }
}
