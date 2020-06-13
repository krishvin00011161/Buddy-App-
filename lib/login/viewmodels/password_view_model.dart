import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/authentication_service.dart';
import 'package:buddyappfirebase/login/services/dialog_service.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

// This is a class that allows to tell the user if the email
// entered in forget email was correct or not.
// DK
class PasswordViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  // Forget My Password
  Future forgetLogin({
    @required String email,
  }) async {
    setBusy(true);

    var result =
        await _authenticationService.recoverPasswordWithEmail(email: email);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService
            .navigateTo(HomeViewRoute); // Success then go to Home View
      } else {
        await _dialogService.showDialog(
          // Fail then put error message
          title: 'Email not found',
          description: 'General credential failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        // Fail put result
        title: 'Credential Failure',
        description: result,
      );
    }
  }
}
