import 'dart:math';

import 'package:flutter/material.dart';

class Logout extends StatefulWidget {
  Logout({Key? key}) : super(key: key);

  @override
  LogoutState createState() => LogoutState();
}

class LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 700,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/mke.jpg'), fit: BoxFit.fill),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  child: Text("LOG IN"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/auth");
                  },
                )),
                SizedBox(width: 30), // give it width
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      )),
                  child: Text("REGISTER"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/reg");
                  },
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
