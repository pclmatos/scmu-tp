import 'dart:convert';
import 'dart:typed_data';

class PhotoEntry {
  Uint8List photoBytes;

  PhotoEntry(this.photoBytes);

  factory PhotoEntry.fromJson(dynamic json) {
    var decodedPhotoBytes = base64Decode(json['photobytes'] as String);

    return PhotoEntry(decodedPhotoBytes);
  }

  Map<String, dynamic> toJson() {
    var photoBase64 = base64Encode(photoBytes);

    return {'photoBytes': photoBase64};
  }
}
