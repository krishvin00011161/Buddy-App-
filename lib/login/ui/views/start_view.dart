import 'dart:math';

import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/login_view.dart';
import 'package:buddyappfirebase/login/ui/views/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class StartView extends StatefulWidget {
  @override
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isAuth = false;
  final NavigationService _navigationService = locator<NavigationService>();


  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        // send the user to the home page
//        Navigator.push(context,
//      MaterialPageRoute(builder: (context) => MainHomeView()),
//      );
      }
    });
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // frog man
            Image(
              width: 150,
              height: 400,
              image: NetworkImage("https://thumbs.gfycat.com/PinkOldfashionedCarpenterant-small.gif"),
            ),
            verticalSpaceMassive,

            // Log In
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 70,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginView(),
                    ),
                  );
                },
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Sign Up
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 70,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SignUpView(),
                    ),
                  );
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
