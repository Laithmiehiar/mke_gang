// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:mke_gang/blocs/internet_bloc/internet_bloc.dart';
import 'package:mke_gang/blocs/internet_bloc/internet_state.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_bloc.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_event.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_state.dart';
import 'package:mke_gang/presentation/pages/LoginPage.dart';
import 'package:mke_gang/presentation/pages/SplashPage.dart';
import 'package:mke_gang/presentation/screens/home.dart';
import 'package:mke_gang/presentation/screens/login.dart';
import 'package:mke_gang/presentation/screens/logout.dart';
import 'package:mke_gang/presentation/widgets/loadingIndicator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // initializeUser();
    // navigateUser();
  }

  Future initializeUser() async {
    // await Firebase.initializeApp();
    // final User firebaseUser = await FirebaseAuth.instance.currentUser;
    // await _auth.currentUser.reload();
    // get User authentication status here
  }

  // navigateUser() async {
  //   // checking whether user already loggedIn or not
  //   if (_auth.currentUser != null) {
  //     // &&  FirebaseAuth.instance.currentUser.reload() != null
  //     Timer(Duration(seconds: 3),
  //         () => Navigator.pushReplacementNamed(context, "/home"));
  //     //   () => Navigator.of(context).pushReplacementNamed(context, "/home"));
  //     //       MaterialPageRoute(
  //     //           builder: (context) => Home(auth: _auth, firestore: _firestore)),
  //     //             (Route<dynamic> route) => false),
  //     // );
  //   } else {
  //     Timer(Duration(seconds: 4),
  //         () => Navigator.pushReplacementNamed(context, "/logout"));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Bloclistener rebuild UI - called multiple times per state (due to flutter engine)
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Here place your app logo, tagline etc..
            Center(
              child: Image.asset('assets/images/bucks.png'),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
                bottom: 30,
              ),
            ),
            // Here place a gif or a loader as I did.
            LoadingIndicator(),
          ],
        ),
      ),
    );
    //Bloclistener rebuild UI - called only once per state
//  BlocListener<SplashScreenBloc, SplashScreenState>(
//       listener: (context, state) {
//         if ((state is Initial) || (state is Loading)) {
//           SplashPage();
//         } else if (state is Loaded) {
//           Home();
//         } else {
//           Logout();
//         }
//       },
//       child: Container(),
  }

  // BlocProvider<SplashScreenBloc> _buildBody(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => SplashScreenBloc(),
  //     child: Container(
  //       height: MediaQuery.of(context).size.height,
  //       width: MediaQuery.of(context).size.width,
  //       color: Colors.orange,
  //       child: Center(
  //         // Here I have used BlocBuilder, but instead you can also use BlocListner as well.
  //         child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
  //           builder: (context, state) {
  //             if ((state is Initial) || (state is Loading)) {
  //               return Scaffold(
  //                 backgroundColor: Colors.white,
  //                 body: Center(
  //                   child: Image.asset('assets/images/bucks.png'),
  //                 ),
  //               );
  //             } else if (state is Loaded) {
  //               return Home();
  //             } else {
  //               return Logout();
  //             }
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
