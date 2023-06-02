import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotncold/models/firestore_game_entry.dart';
import 'package:hotncold/models/firestore_user.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addUser(FirestoreUser user) async {
    final CollectionReference collectionRef = firestore.collection('users');
    DocumentReference documentRef = collectionRef.doc(user.email);
    documentRef.set(user.toMap());
  }

  Future<FirestoreUser> getUser(String email) async {
    DocumentReference docRef = firestore.collection("users").doc(email);

    DocumentSnapshot snapshot = await docRef.get();

    FirestoreUser? user;
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      user = FirestoreUser.fromMap(data);
    }

    return user!;
  }

  Future<FirestoreGameEntry> getGame(String id) async {
    DocumentReference docRef = firestore.collection("games").doc(id);

    DocumentSnapshot snapshot = await docRef.get();

    FirestoreGameEntry? game;
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      game = FirestoreGameEntry.fromMap(data);
    }

    return game!;
  }
}
