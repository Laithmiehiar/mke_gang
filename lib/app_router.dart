import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mke_gang/presentation/pages/SplashPage.dart';
import 'package:mke_gang/presentation/screens/home.dart';
import 'package:mke_gang/presentation/screens/login.dart';
import 'package:mke_gang/presentation/screens/logout.dart';
import 'package:mke_gang/presentation/screens/registration.dart';
import 'package:mke_gang/presentation/screens/splash.dart';

// Defining routes for navigation

class AppRouter {
  const AppRouter._();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute<SplashScreen>(
          builder: (_) => SplashPage(),
        );
      case '/auth':
        return MaterialPageRoute<Login>(
          builder: (_) => Login(),
        );
      // case '/home':
      //   return MaterialPageRoute<Home>(
      //     builder: (_) => Home(auth: _auth, firestore: _firestore),
      //   );
      case '/logout':
        return MaterialPageRoute<Logout>(
          builder: (_) => Logout(),
        );
      case '/reg':
      // return MaterialPageRoute<Registration>(
      //   builder: (_) => Registration(auth: _auth, firestore: _firestore),
      // );
      default:
        throw RouteException("Route not found");
    }
  }

  static const homePage = '/';
}

/// Exception thrown when a given route doesn't exist
class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
