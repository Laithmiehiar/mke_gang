import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mke_gang/repositories/user_repository.dart';

class FirebaseUserRepository extends UserRepository {
  const FirebaseUserRepository();

  @override
  Future<bool> authenticate(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  Future<bool> register(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  Future<void> logOut() => FirebaseAuth.instance.signOut();

  @override
  String get signedEmail {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return user.email;
    } else {
      return "";
    }
  }
}
