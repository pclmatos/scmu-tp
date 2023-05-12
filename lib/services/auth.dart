// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';

import 'package:hotncold/models/user.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  MyUser? userFromFireBaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? MyUser(uid: user.uid, email: user.email) : null;
  }

  Stream<MyUser?> get user {
    return auth.authStateChanges().map(userFromFireBaseUser);
  }

  Future registerWithEmailAnPassword(String email, String pwd) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      User? user = result.user;
      return userFromFireBaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInEmailAndPassword(String email, String pwd) async {
    try {
      UserCredential result =
          await auth.signInWithEmailAndPassword(email: email, password: pwd);
      User? user = result.user;
      return userFromFireBaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
