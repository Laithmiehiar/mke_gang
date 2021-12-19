import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/blocs/authentication_bloc/authentication_event.dart';
import 'package:mke_gang/blocs/authentication_bloc/authentication_state.dart';
import 'package:mke_gang/repositories/firebase_repository.dart';
import 'package:mke_gang/repositories/user_repository.dart';

/// Manages the authentication state of the app
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc(this.userRepository) : super(AuthenticationInit()) {
    on((event, emit) async {
      if (event is LoggedIn) {
        _loggedIn();
      }
      if (event is LoggedOut) {
        _loggedOut();
      }
    });
  }

  void _loggedIn() => emit(AuthenticationSuccess());

  void _loggedOut() async {
    emit(AuthenticationLoading());
    await userRepository.logOut();
    emit(AuthenticationRevoked());
  }
}
