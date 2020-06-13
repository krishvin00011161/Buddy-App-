import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainHomeView extends StatefulWidget {
  @override
  _MainHomeViewState createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();

  Scaffold mainHomeView() {
    // The home view in 1st tab bar
    int _currentIndex = 0;
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawers(),
      
    );
  }



  logout() {
    googleSignIn.signOut();
    _navigationService.navigateTo(StartViewRoute);
  }

  @override
  Widget build(BuildContext context) {
    return mainHomeView();
  }
}