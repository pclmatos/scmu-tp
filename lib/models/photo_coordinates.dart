import 'dart:convert';

class PhotoEntry {
  double lat;
  double lon;
  List<int> photoBytes;

  PhotoEntry(this.lat, this.lon, this.photoBytes);

  factory PhotoEntry.fromJson(dynamic json) {
    return PhotoEntry(json['lat'], json['lon'], json['photoBytes']);
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lon': lon, 'photoBytes': photoBytes};
  }
}
