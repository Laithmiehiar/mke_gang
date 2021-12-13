import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

import 'package:mke_gang/models/User.dart';

class Users {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  Users({required this.auth, required this.firestore});
  final collectionName = "users";

  Future<String> addUser(
      {required String email,
      required String name,
      required String phone,
      required String dateOfBirth,
      required String address}) async {
    var rng = new Random();
    var accountId = rng.nextInt(900000) + 100000;

    print(accountId);
    var result = await firestore
        .collection(collectionName)
        .doc(auth.currentUser.uid)
        .set({
      "name": name,
      "address": address,
      "phone": phone,
      "birthdate": dateOfBirth,
      "email": email,
      "accountId": accountId,
      "active": true,
    }).then((value) {
      return "Success";
    }).catchError((error) {
      print("Failed to add user: $error");
      return "False";
    });
    return result;
  }

  Future<QuerySnapshot> getUsers() {
    return firestore
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot;
    });
  }
}
