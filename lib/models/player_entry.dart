class PlayerEntry {
  String email;
  String state;

  PlayerEntry(this.email, this.state);

  factory PlayerEntry.fromJson(dynamic json) {
    return PlayerEntry(json['email'], json['state']);
  }
}
