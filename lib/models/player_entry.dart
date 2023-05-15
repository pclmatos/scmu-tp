import 'dart:convert';

class PlayerEntry {
  String email;
  String state;

  PlayerEntry(this.email, this.state);

  factory PlayerEntry.fromJson(dynamic json) {
    //var decodedJson = jsonDecode(json);
    print(json);
    return PlayerEntry(json['email'] as String, json['state'] as String);
  }
}
