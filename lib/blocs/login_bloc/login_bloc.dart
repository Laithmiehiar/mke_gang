import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/blocs/authentication_bloc.dart';
import 'package:mke_gang/blocs/login_bloc/login_event.dart';
import 'package:mke_gang/blocs/login_bloc/login_state.dart';
import 'package:mke_gang/repositories/user_repository.dart';

/// Manages the login state of the app
class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
  CredentialsBloc({
    required this.authenticationBloc,
    required this.userRepository,
  }) : super(CredentialsInitial()) {
    on((event, emit) async {
      if (event is LoginButtonPressed) {
        _loginPressed(event);
      } else if (event is RegisterButtonPressed) {
        _registerPressed(event);
      }
    });
  }

  Stream<CredentialsState> _loginPressed(CredentialsEvent event) async* {
    print("test1");
    emit(CredentialsLoginLoading());

    try {
      final success =
          await userRepository.authenticate(event.email, event.password);

      if (success) {
        authenticationBloc.add(const LoggedIn());
        emit(CredentialsInitial());
      } else {
        emit(CredentialsLoginFailure());
      }
    } on FirebaseAuthException {
      emit(CredentialsLoginFailure());
    }
  }

  Stream<CredentialsState> _registerPressed(CredentialsEvent event) async* {
    emit(CredentialsRegisterLoading());

    try {
      final success =
          await userRepository.register(event.email, event.password);

      if (success) {
        authenticationBloc.add(const LoggedIn());
        emit(CredentialsInitial());
      } else {
        emit(CredentialsRegisterFailure());
      }
    } on FirebaseAuthException {
      emit(CredentialsRegisterFailure());
    }
  }
}
