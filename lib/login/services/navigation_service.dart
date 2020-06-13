import 'package:flutter/material.dart';

// This class makes it able to navigate to other views
// Dk

class NavigationService { // Service to navigate across pages
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

 void pop() {
   // bool
   return _navigationKey.currentState.pop();
 }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }
}
