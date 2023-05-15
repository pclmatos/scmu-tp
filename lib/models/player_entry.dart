class PlayerEntry {
  String email;
  String state;

  PlayerEntry(this.email, this.state);

  factory PlayerEntry.fromJson(dynamic json) {
    //var decodedJson = jsonDecode(json);
    return PlayerEntry(json['email'] as String, json['state'] as String);
  }

  @override
  String toString() {
    return 'PlayerEntry [email=$email, state=$state]';
  }
}
