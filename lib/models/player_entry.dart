import 'dart:convert';

class PlayerEntry {
  String email;
  String state;

  PlayerEntry(this.email, this.state);

  factory PlayerEntry.fromJson(dynamic json) {
    return PlayerEntry(json['email'], json['state']);
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'state': state};
  }

  @override
  String toString() {
    return 'PlayerEntry [email=$email, state=$state]';
  }
}
