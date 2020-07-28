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
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  bool showSignIn = true;

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
        //scaffoldBackgroundColor: Colors.white,
        accentColor: Color(0xFFFEF9EB),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: Authenticate(),
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
