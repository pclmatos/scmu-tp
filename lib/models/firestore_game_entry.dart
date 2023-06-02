import 'package:hotncold/models/firestore_game.dart';

class FirestoreGameEntry {
  final String id;
  final FirestoreGame game;

  FirestoreGameEntry(this.id, this.game);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'game': game,
    };
  }

  factory FirestoreGameEntry.fromMap(Map<String, dynamic> map) {
    return FirestoreGameEntry(
        map['id'], FirestoreGame.fromMap(map['firestoreGame']));
  }
}
