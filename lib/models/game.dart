import 'package:hotncold/models/round.dart';
import 'package:hotncold/models/score.dart';

class Game {
  List<Round> rounds = [];
  int currentRound = 0;
  List<Score> scores = [];

  Game(this.rounds, this.currentRound, this.scores);

  factory Game.fromJson(dynamic json) {
    List<dynamic> roundsTmp = json['rounds'] as List;

    List<Round> tmp = [];
    for (var entry in roundsTmp) {
      tmp.add(Round.fromJson(entry));
    }

    List<Score> scoresTmp = [];
    for (var entry in json['scores']) {
      scoresTmp.add(Score.fromJson(entry));
    }

    return Game(tmp, json['currentRound'] as int, scoresTmp);
  }

  Map<String, dynamic> toJson() {
    return {'rounds': rounds, 'currentRound': currentRound};
  }
}
