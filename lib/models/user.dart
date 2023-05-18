class MyUser {
  final String uid;
  final String? email;

  MyUser({required this.uid, required this.email});

  @override
  String toString() {
    return "MyUser {uid=$uid, email=$email}";
  }
}
