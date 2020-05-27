import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:buddyappfirebase/login/ui/widgets/route_transition.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // FirebaseUser _user;

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      // ),
      body: PageView(
        children: <Widget>[
          RaisedButton(
            child: Text('Logout'),
            onPressed: () {
              logout();
              setState(() {
                Navigator.of(context)
                    .push(Transition().createRoute(StartView()));
              });
            },
          ),
        ],
      ),
    );
  }

  bool isSignIn = false;

  logout() {
    googleSignIn.signOut();
  }
}
