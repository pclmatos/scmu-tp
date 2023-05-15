class PlayerEntry {
  String email;
  String state;

  PlayerEntry(this.email, this.state);

  factory PlayerEntry.fromJson(dynamic json) {
    //var decodedJson = jsonDecode(json);
    return PlayerEntry(json['email'] as String, json['state'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'state': state};
  }

  @override
  String toString() {
    return 'PlayerEntry [email=$email, state=$state]';
  }
}
