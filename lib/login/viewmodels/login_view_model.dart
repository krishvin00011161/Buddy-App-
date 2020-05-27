import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/authentication_service.dart';
import 'package:buddyappfirebase/login/services/dialog_service.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

class LoginViewModel extends BaseModel {
  // All backend service for the login page
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  // Requiring Email and Password
  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService
            .navigateTo(HomeViewRoute); // Success then it push to Home view
      } else {
        await _dialogService.showDialog(
          // If not say Login failure
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        // If not say result description
        title: 'Login Failure',
        description: result,
      );
    }
  }
}
