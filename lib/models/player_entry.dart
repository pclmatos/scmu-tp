class PlayerEntry {
  String email;
  String state;
  String role;

  PlayerEntry(this.email, this.state, this.role);

  factory PlayerEntry.fromJson(dynamic json) {
    //var decodedJson = jsonDecode(json);
    return PlayerEntry(json['email'], json['state'], json['role']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'state': state, 'role': role};
  }

  @override
  String toString() {
    return 'PlayerEntry [email=$email, state=$state, role=$role]';
  }
}
