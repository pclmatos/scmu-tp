class FirestoreUser {
  final List<String> gameIds;
  final String email;

  FirestoreUser(this.email, this.gameIds);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'gameIds': gameIds,
    };
  }

  factory FirestoreUser.fromMap(Map<String, dynamic> map) {
    return FirestoreUser(
      map['email'],
      List<String>.from(map['gameIds']),
    );
  }
}
