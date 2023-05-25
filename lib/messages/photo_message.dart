import 'dart:convert';

import 'package:hotncold/models/photo_entry.dart';

class HiderMessage {
  String type;
  String code;
  PhotoEntry content;

  HiderMessage(this.type, this.code, this.content);

  factory HiderMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return HiderMessage(
        decoded['type'], decoded['code'], PhotoEntry.fromJson(decoded));
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'code': code, 'content': content};
  }
}
