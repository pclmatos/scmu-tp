import 'dart:convert';

import 'package:hotncold/models/confirmation_entry.dart';

class ConfirmationMessage {
  String type;
  ConfirmationEntry content;

  ConfirmationMessage(this.type, this.content);

  factory ConfirmationMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return ConfirmationMessage(decoded['type'], decoded['content']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
