import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_event.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc(SplashScreenState initialState) : super(initialState) {
    on((event, emit) async {
      if (event is NavigateToHomeScreenEvent) {
        _loading();

        await Future.delayed(Duration(
            seconds: 5)); // This is to simulate that above checking process

        _loaded();
      }
    });
  }

  void _loading() => emit(Loading());
  void _loaded() => emit(Loaded());

  // Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
  //   if (event is NavigateToHomeScreenEvent) {
  //     yield Loading();

  //     // During the Loading state we can do additional checks like,
  //     // if the internet connection is available or not etc..

  //     await Future.delayed(Duration(
  //         seconds: 4)); // This is to simulate that above checking process
  //     yield Loaded(); // In this state we can load the HOME PAGE

  //   }
  // }
}
