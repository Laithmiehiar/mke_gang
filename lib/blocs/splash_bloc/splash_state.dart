import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  const SplashScreenState();

  @override
  List<Object> get props => [];
}

class Initial extends SplashScreenState {
  const Initial();
}

class Loading extends SplashScreenState {
  const Loading();
}

class Loaded extends SplashScreenState {
  const Loaded();
}
