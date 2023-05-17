import 'package:hotncold/models/round.dart';

class Game {
  List<Round> rounds = [];
  int currentRound = 0;

  Game(this.rounds, this.currentRound);

  factory Game.fromJson(dynamic json) {
    List<dynamic> roundsTmp = json['rounds'] as List;

    List<Round> tmp = [];
    for (var entry in roundsTmp) {
      tmp.add(Round.fromJson(entry));
    }

    return Game(tmp, json['currentRound'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'rounds': rounds, 'currentRound': currentRound};
  }
}
