import 'package:buddyappfirebase/chat/models/user_model.dart';
import 'package:buddyappfirebase/services/authentication_service.dart';
import 'package:buddyappfirebase/services/dialog_service.dart';
import 'package:buddyappfirebase/services/navigation_service.dart';
import 'package:buddyappfirebase/locator.dart';
import 'package:buddyappfirebase/constants/route_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  User currentUser;
  

  Future signUp({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        // Success
        _navigationService.navigateTo(HomeViewRoute);


      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }

   
  }

  
}
