import 'dart:convert';

class WrongCodeMessage {
  String type;

  WrongCodeMessage(this.type);

  factory WrongCodeMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return WrongCodeMessage(decoded['type']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}
