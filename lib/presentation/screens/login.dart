import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mke_gang/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:mke_gang/blocs/authentication_bloc/authentication_state.dart';
import 'package:mke_gang/blocs/login_bloc/login_bloc.dart';
import 'package:mke_gang/blocs/login_bloc/login_event.dart';
import 'package:mke_gang/blocs/login_bloc/login_state.dart';
import 'package:mke_gang/blocs/splash_bloc/splash_event.dart';
import 'package:mke_gang/constants/color_constants.dart';
import 'package:mke_gang/constants/resources.dart';
import 'package:mke_gang/localization/app_localization.dart';
import 'package:mke_gang/presentation/screens/home.dart';
import 'package:mke_gang/presentation/widgets/loadingIndicator.dart';
import 'package:mke_gang/presentation/widgets/separator.dart';
import 'package:mke_gang/services/auth.dart';

late String name;
late String email;
late String imageUrl;

final GoogleSignIn googleSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  // final FirebaseAuth auth;
  // final FirebaseFirestore firestore;

  const Login({
    Key? key,
    // required this.auth,
    // required this.firestore,
  }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<CredentialsBloc>(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      if (state is CredentialsInitial) {
        _emailController.clear();
        _passwordController.clear();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false);
      } else if (state is CredentialsLoginLoading) {
        LoadingIndicator();
      } else if (state is CredentialsLoginFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Wrong Credentials"),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0, // elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(backButton, width: 20, height: 20),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.only(left: 8),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            // width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 40, top: 10),
                                  child: Text(
                                    context.localize("login"),
                                    style: GoogleFonts.nunito(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: kGreyColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Separator(10),
                          ]),
                      Container(
                        child: SingleChildScrollView(
                            child: Form(
                          key: formKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Column(
                              children: [
                                buildEmail(),
                                const SizedBox(height: 20),
                                buildPassword(),
                              ],
                            ),
                          ),
                        )),
                      ),
                      const Separator(20),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            // padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border(
                                    bottom: BorderSide(color: Colors.black),
                                    top: BorderSide(color: Colors.black),
                                    right: BorderSide(color: Colors.black),
                                    left: BorderSide(color: Colors.black))),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: () async {
                                final isValid =
                                    formKey.currentState!.validate();
                                FocusScope.of(context).unfocus();

                                if (isValid) {
                                  formKey.currentState!.save();
                                  _loginBloc.add(LoginButtonPressed(
                                      email: _emailController.text,
                                      password: _passwordController.text));

                                  //   final String retVal =
                                  //       await Auth(auth: widget.auth).signIn(
                                  //     email: _emailController.text,
                                  //     password: _passwordController.text,
                                  //   );
                                  //   if (retVal == "Success") {
                                  //     _emailController.clear();
                                  //     _passwordController.clear();

                                  //     Navigator.of(context).pushAndRemoveUntil(
                                  //         MaterialPageRoute(
                                  //             builder: (context) => Home(
                                  //                 auth: widget.auth,
                                  //                 firestore: widget.firestore)),
                                  //         (Route<dynamic> route) => false);
                                  //   } else {
                                  //     ScaffoldMessenger.of(context).showSnackBar(
                                  //       SnackBar(
                                  //         content: Text(retVal),
                                  //       ),
                                  //     );
                                  //   }
                                }
                              },
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: kWhiteColor),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      // }
    });
  }

  Widget buildEmail() => TextFormField(
        obscureText: false,
        controller: _emailController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: "Email",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kGreyColor,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
        ),
        validator: (value) {
          final pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);

          if (value!.isEmpty) {
            return 'Enter an email';
          } else if (!regExp.hasMatch(value)) {
            return 'Enter a valid email';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
        // onSaved: (value) => setState(() => email = value!),
      );

  Widget buildPassword() => TextFormField(
        obscureText: true,
        controller: _passwordController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password),
          labelText: "Password",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kGreyColor,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
        ),
        validator: (value) {
          if (value!.length < 7) {
            return 'Password must be at least 7 characters long';
          } else {
            return null;
          }
        },
        // onSaved: (value) => setState(() => password = value!),
        keyboardType: TextInputType.visiblePassword,
      );
}
