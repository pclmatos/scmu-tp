class Score {
  final String email;
  final int score;

  Score(this.email, this.score);

  factory Score.fromJson(dynamic json) {
    return Score(json['email'], json['score']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'score': score,
    };
  }
}
