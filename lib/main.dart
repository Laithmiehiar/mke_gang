import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:mke_gang/constants/color_constants.dart';
import 'package:mke_gang/screens/home.dart';
import 'package:mke_gang/screens/login.dart';
import 'package:mke_gang/screens/logout.dart';
import 'package:mke_gang/screens/registration.dart';
import 'package:mke_gang/screens/splash.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => Login(auth: _auth, firestore: _firestore),
  "/home": (BuildContext context) => Home(auth: _auth, firestore: _firestore),
  "/logout": (BuildContext context) => Logout(),
  "/reg": (BuildContext context) =>
      Registration(auth: _auth, firestore: _firestore),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
        backgroundColor: kBackgroundColor),
    title: 'FaceBase',
    routes: routes,
    home: SplashScreen(),
  ));
}
