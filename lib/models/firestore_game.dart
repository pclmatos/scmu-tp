import 'package:hotncold/models/round.dart';
import 'package:hotncold/models/score.dart';

class FirestoreGame {
  final List<Score> scores;
  final List<Round> rounds;

  FirestoreGame(this.scores, this.rounds);

  Map<String, dynamic> toMap() {
    return {
      'scores': scores,
      'rounds': rounds,
    };
  }

  factory FirestoreGame.fromMap(Map<String, dynamic> map) {
    List<Score> tmpScores = [];
    List<Round> tmpRounds = [];

    for (var score in map['scores']) {
      Score tmp = Score.fromJson(score);
      tmpScores.add(tmp);
    }

    for (var round in map['rounds']) {
      Round tmp = Round.fromJson(round);

      tmpRounds.add(tmp);
    }

    return FirestoreGame(tmpScores, tmpRounds);
  }
}
