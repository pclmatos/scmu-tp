import 'dart:convert';

import 'package:hotncold/models/code_entry.dart';

class CodeMessage {
  String type;
  CodeEntry content;

  CodeMessage(this.type, this.content);

  factory CodeMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return CodeMessage(decoded['type'], CodeEntry.fromJson(decoded));
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': content};
  }
}
