/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Start point/Auto Log-in helper
  Description: It allows to save the login and help log in faster by skipping the sign-in process


 */

import 'package:buddyappfirebase/GlobalWidget/authenticate.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home/screens/MainHomeView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  bool showSignIn = true;

  @override
  void initState() {
    super.initState();
    getLoggedInState();
  }

  // function that checks if user is logged in.
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  // Helps toggle between Sign Up/Sign In Page
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  // Builds the UI of the Main page
  MaterialApp body() {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Color(0xFFFEF9EB),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home: ProfilePage(),
      home: userIsLoggedIn != null
          ? userIsLoggedIn ? MainHomeView() : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return body();
  }
}
