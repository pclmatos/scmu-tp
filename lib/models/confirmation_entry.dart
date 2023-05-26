class ConfirmationEntry {
  String code;
  int tick;

  ConfirmationEntry(this.code, this.tick);

  factory ConfirmationEntry.fromJson(dynamic json) {
    return ConfirmationEntry(json['code'], json['tick']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'time': tick};
  }
}
