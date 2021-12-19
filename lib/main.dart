import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/app_router.dart';
import 'package:mke_gang/blocs/authentication_bloc.dart';
import 'package:mke_gang/blocs/internet_bloc/internet_bloc.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_bloc.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_state.dart';
import 'package:mke_gang/constants/color_constants.dart';
import 'package:mke_gang/localization/localization_delegate.dart';
import 'package:mke_gang/localization/app_localization.dart';

import 'package:mke_gang/repositories/firebase_repository.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Defining routes for navigation
// var routes = <String, WidgetBuilder>{
//   "/auth": (BuildContext context) => Login(auth: _auth, firestore: _firestore),
//   "/home": (BuildContext context) => Home(auth: _auth, firestore: _firestore),
//   "/logout": (BuildContext context) => Logout(),
//   "/reg": (BuildContext context) =>
//       Registration(auth: _auth, firestore: _firestore),
// };

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//         colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
//         backgroundColor: kBackgroundColor),
//     title: 'FaceBase',
//     routes: routes,
//     home: SplashScreen(),
//   ));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Provider<FirebaseUserRepository>(
    create: (_) => const FirebaseUserRepository(),
    child: MyApp(connectivity: Connectivity()),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;

  const MyApp({required this.connectivity});

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository r) => r);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (authenticationcontext) => AuthenticationBloc(repository),
        ),
        BlocProvider<SplashScreenBloc>(
          create: (splashScreencontext) => SplashScreenBloc(Initial()),
        ),
        BlocProvider<InternetBloc>(
          create: (internetcontext) => InternetBloc(connectivity: connectivity),
        ),
      ],
      child: MaterialApp(
        initialRoute: AppRouter.homePage,
        onGenerateRoute: AppRouter.onGenerateRoute,
        localizationsDelegates: [
          const AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale.fromSubtags(languageCode: "en"),
          Locale.fromSubtags(languageCode: "ar"),
        ],
        onGenerateTitle: (context) => context.localize("title"),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
            backgroundColor: kBackgroundColor),
      ),
    );
  }
}
