import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mke_gang/constants/color_constants.dart';
import 'package:mke_gang/constants/resources.dart';
import 'package:mke_gang/custom_icons/MyFlutterApp.dart';
import 'package:mke_gang/presentation/screens/home.dart';
import 'package:mke_gang/services/auth.dart';
import 'package:mke_gang/services/users.dart';

class Registration extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  Registration({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                  "Sign up",
                                  style: GoogleFonts.nunito(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: kGreyColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 60),
                                child: Text(
                                  "Create an Account",
                                  style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ]),
                    Container(
                      child: SingleChildScrollView(
                          child: Form(
                        key: formKey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              buildName(),
                              const SizedBox(height: 20),
                              buildEmail(),
                              const SizedBox(height: 20),
                              buildPassword(),
                              const SizedBox(height: 20),
                              buildPhone(),
                              const SizedBox(height: 20),
                              buildDateOfBirth(),
                              const SizedBox(height: 20),
                              buildAddress(),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      )),
                    ),
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
                              final isValid = formKey.currentState!.validate();
                              FocusScope.of(context).unfocus();

                              // if (isValid) {
                              //   formKey.currentState!.save();

                              //   final String retVal =
                              //       await Auth(auth: widget.auth).createAccount(
                              //     email: _emailController.text,
                              //     password: _passwordController.text,
                              //   );
                              //   if (retVal == "Success") {
                              //     final String result = await Users(
                              //             auth: widget.auth,
                              //             firestore: widget.firestore)
                              //         .addUser(
                              //             email: _emailController.text,
                              //             name: _nameController.text,
                              //             dateOfBirth: _dobController.text,
                              //             address: _addressController.text,
                              //             phone: _phoneController.text);

                              //     if (result == "Success") {
                              //       _emailController.clear();
                              //       _nameController.clear();
                              //       _dobController.clear();
                              //       _addressController.clear();
                              //       _phoneController.clear();
                              //       _passwordController.clear();

                              //       Navigator.of(context).pushAndRemoveUntil(
                              //           MaterialPageRoute(
                              //               builder: (context) => Home(
                              //                   auth: widget.auth,
                              //                   firestore: widget.firestore)),
                              //           (Route<dynamic> route) => false);
                              //     } else {
                              //       ScaffoldMessenger.of(context).showSnackBar(
                              //         SnackBar(
                              //           content: Text(retVal),
                              //         ),
                              //       );
                              //     }
                              //   } else {
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //         content: Text(retVal),
                              //       ),
                              //     );
                              //   }
                              // }
                            },
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: Text(
                              "Sign Up",
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
  }

  Widget buildName() => TextFormField(
        obscureText: false,
        controller: _nameController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: "Name",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kGreyColor,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
        ),
        validator: (value) {
          if (value!.length < 4) {
            return 'Enter at least 4 characters';
          } else {
            return null;
          }
        },
        maxLength: 30,
        // onSaved: (value) => setState(() => name = value!),
      );
  Widget buildAddress() => TextFormField(
        obscureText: false,
        controller: _addressController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on),
          labelText: "Address",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kGreyColor,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter your address';
          } else {
            return null;
          }
        },
        maxLength: 30,
        // onSaved: (value) => setState(() => name = value!),
      );
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

  Widget buildPhone() => TextFormField(
        obscureText: false,
        controller: _phoneController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          labelText: "Phone",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kGreyColor,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
        ),
        validator: (value) {
          if (value!.length != 10) {
            return 'Phone length must be at 10 characters long';
          } else {
            return null;
          }
        },
        // onSaved: (value) => setState(() => phone = value!),
        keyboardType: TextInputType.number,
      );
  Widget buildDateOfBirth() => TextFormField(
        obscureText: false,
        controller: _dobController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.calendar_today),
          labelText: "Date Of Birth",
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: kGreyColor,
            ),
          ),
          border: OutlineInputBorder(borderSide: BorderSide(color: kGreyColor)),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  1400), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('MM-dd-yyyy').format(pickedDate);
            print(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            //you can implement different kind of Date Format here according to your requirement

            setState(() {
              _dobController.text =
                  formattedDate; //set output date to TextField value.
            });
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Date of birth is not selected';
          } else {
            return null;
          }
        },
        // onSaved: (value) => setState(() => dob = value!),
        // keyboardType: TextInputType.datetime,
      );
}
