import 'dart:convert';

class Message {
  String type;
  dynamic content;

  Message(this.type, this.content);

  factory Message.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return Message(decoded['type'] as String, decoded['contents']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
