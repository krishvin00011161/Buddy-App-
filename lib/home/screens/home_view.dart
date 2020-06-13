import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/message/message.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends StatefulWidget { // The main place, where you put all your views together.
  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = new GoogleSignIn();
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Scaffold homeScreen() {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          MainHomeView(),
          ExplorePage(),
          MessageScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.chat)),
          ]),
    );
  }

  bool isSignIn = false;

  logout() {
    googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return homeScreen();
  }
}
