import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mke_gang/blocs/authentication_bloc.dart';
import 'package:mke_gang/blocs/login_bloc/login_bloc.dart';
import 'package:mke_gang/presentation/screens/login.dart';
import 'package:mke_gang/repositories/firebase_repository.dart';
import 'package:mke_gang/localization/app_localization.dart';

/// First widget to appear when the application starts containing
/// the [LoginForm] form.
class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    final repository = context.select((FirebaseUserRepository u) => u);
    final authBloc = context.read<AuthenticationBloc>();

    return Scaffold(
      body: BlocProvider<CredentialsBloc>(
        create: (context) => CredentialsBloc(
          authenticationBloc: authBloc,
          userRepository: repository,
        ),
        child: const Center(child: Login()),
      ),
    );
  }
}
