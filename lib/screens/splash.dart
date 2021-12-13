// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    initializeUser();
    navigateUser();
  }

  Future initializeUser() async {
    await Firebase.initializeApp();
    // final User firebaseUser = await FirebaseAuth.instance.currentUser;
    await _auth.currentUser.reload();
    // get User authentication status here
  }

  navigateUser() async {
    // checking whether user already loggedIn or not
    if (_auth.currentUser != null) {
      // &&  FirebaseAuth.instance.currentUser.reload() != null
      Timer(Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, "/home"));
      //   () => Navigator.of(context).pushReplacementNamed(context, "/home"));
      //       MaterialPageRoute(
      //           builder: (context) => Home(auth: _auth, firestore: _firestore)),
      //             (Route<dynamic> route) => false),
      // );
    } else {
      Timer(Duration(seconds: 4),
          () => Navigator.pushReplacementNamed(context, "/logout"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/bucks.png'),
      ),
    );
  }
}
