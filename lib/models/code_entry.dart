class CodeEntry {
  String code;
  double lat;
  double lon;

  CodeEntry(this.code, this.lat, this.lon);

  factory CodeEntry.fromJson(dynamic json) {
    return CodeEntry(json['code'], json['lat'], json['lon']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'lat': lat, 'lon': lon};
  }
}
