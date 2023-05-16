import 'dart:convert';

class LeaveMessage {
  String type;

  LeaveMessage(this.type);

  factory LeaveMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return LeaveMessage(decoded['type'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}
