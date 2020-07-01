import 'dart:math';

import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/login_view.dart';
import 'package:buddyappfirebase/login/ui/views/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../locator.dart';



class StartView extends StatefulWidget {
  @override
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  bool isAuth = false;
  final NavigationService _navigationService = locator<NavigationService>();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
//      if (firebaseUser != firebaseUser) {
//        print("true");
//        handleSignIn(firebaseUser);
//      } else {
//        print("On login");
//      }
//      //handleSignIn(firebaseUser);
//      _navigationService.navigateTo(MainHomeViewRoute);
//    }, onError: (err) {
//      print('Error signing in: $err');
//    }
//    );
//      print(FirebaseUser);
//  }
//
//  handleSignIn(FirebaseUser user) {
//    if (user != null) {
//      setState(() {
//        isAuth = true;
//      });
//    } else {
//      setState(() {
//        isAuth = false;
//      });
//    }
//  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(LoginView.loggedIn);
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
              height: 80,
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
              height: 80,
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
