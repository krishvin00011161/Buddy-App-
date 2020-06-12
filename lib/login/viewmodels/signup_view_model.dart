import 'package:buddyappfirebase/chat/models/user_model.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/authentication_service.dart';
import 'package:buddyappfirebase/login/services/dialog_service.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  // Takes care of the backend of sign up
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  User currentUser;

  Future signUp({
    // Requires email and password and name
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService
            .navigateTo(WelcomeViewRoute); // Success then push to Home View

      } else {
        await _dialogService.showDialog(
          // Failure then try again
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        // Failure then say what happened
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}
