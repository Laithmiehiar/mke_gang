import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/blocs/internet_bloc/internet_bloc.dart';
import 'package:mke_gang/blocs/internet_bloc/internet_state.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_bloc.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_event.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_state.dart';
import 'package:mke_gang/presentation/pages/LoginPage.dart';
import 'package:mke_gang/presentation/screens/logout.dart';
import 'package:mke_gang/presentation/screens/splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage();

  @override
  SplashPagetState createState() => SplashPagetState();
}

class SplashPagetState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    this._dispatchHomeScreen(
        context); // This will dispatch the navigateToHomeScreen event.
  }

  // return Scaffold(
  //   backgroundColor: Colors.white,
  //   body: Center(
  //     child: Image.asset('assets/images/bucks.png'),
  //   ),
  // );
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetBloc, InternetState>(
        listener: (internetContext, internetState) {
      if (internetState is InternetConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Internet Connection Connected!'),
            duration: Duration(milliseconds: 1000),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Internet Connection Disconnected!'),
            duration: Duration(milliseconds: 1000),
          ),
        );
      }
    }, builder: (internetContext, internetState) {
      return Scaffold(
        body: BlocBuilder<SplashScreenBloc, SplashScreenState>(
          builder: (splashContext, splashState) {
            if ((internetState is InternetConnected) &&
                    (splashState is Initial) ||
                (splashState is Loading)) {
              return SplashScreen();
            } else if ((internetState is InternetConnected) &&
                splashState is Loaded) {
              return LoginPage();
              // return BlocProvider.value(
              //     value: BlocProvider.of<AuthenticationBloc>(context),
              //     child: Home());
            } else {
              return Logout();
            }
          },
        ),
      );
    });
  }

  //This method will dispatch the navigateToHomeScreen event.
  void _dispatchHomeScreen(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(
      NavigateToHomeScreenEvent(),
    );
  }

  void _dispatchLoginScreen(BuildContext context) {
    BlocProvider.of<SplashScreenBloc>(context).add(
      NavigateToHomeScreenEvent(),
    );
  }
}
