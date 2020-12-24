import 'package:buddyappfirebase/Message/helper/authenticate.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:flutter/material.dart';
import 'home/screens/MainHomeView.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // Register all the models and services before the app starts
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Boolean value that check if users is logged in
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  // function that checks if user is logged in.
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  bool showSignIn = true;

  // Helps toggle between Sign Up/Sign In
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Color(0xFFFEF9EB),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null
          ? userIsLoggedIn ? MainHomeView() : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }
}
