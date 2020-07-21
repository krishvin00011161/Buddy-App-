import 'package:buddyappfirebase/testMessage/views/signin.dart';
import 'package:buddyappfirebase/testMessage/views/signup.dart';
import 'package:flutter/material.dart';

// This needs a change

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}