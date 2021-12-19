import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Events for the [LoginBloc] bloc
abstract class CredentialsEvent extends Equatable {
  final String email;
  final String password;
  const CredentialsEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

/// Event fired when the login button is tapped
class LoginButtonPressed extends CredentialsEvent {
  const LoginButtonPressed({required String email, required String password})
      : super(email, password);
}

/// Event fired when the register button is tapped
class RegisterButtonPressed extends CredentialsEvent {
  const RegisterButtonPressed({required String email, required String password})
      : super(email, password);
}
