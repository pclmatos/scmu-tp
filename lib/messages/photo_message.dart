import 'dart:convert';

import 'package:hotncold/models/photo_coordinates.dart';

class PhotoMessage {
  String type;
  PhotoEntry content;

  PhotoMessage(this.type, this.content);

  factory PhotoMessage.fromJson(dynamic json) {
    var decoded = jsonDecode(json);

    return PhotoMessage(decoded['type'], PhotoEntry.fromJson(decoded));
  }
}
