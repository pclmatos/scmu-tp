import 'dart:convert';
import 'dart:typed_data';

class PhotoEntry {
  double lat;
  double lon;
  Uint8List photoBytes;

  PhotoEntry(this.lat, this.lon, this.photoBytes);

  factory PhotoEntry.fromJson(dynamic json) {
    var decodedPhotoBytes = base64Decode(json['photobytes']);

    return PhotoEntry(json['lat'], json['lon'], decodedPhotoBytes);
  }

  Map<String, dynamic> toJson() {
    var photoBase64 = base64Encode(photoBytes);

    return {'lat': lat, 'lon': lon, 'photoBytes': photoBase64};
  }
}
