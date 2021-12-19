import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class NavigateToHomeScreenEvent extends SplashScreenEvent {
  const NavigateToHomeScreenEvent();
}
