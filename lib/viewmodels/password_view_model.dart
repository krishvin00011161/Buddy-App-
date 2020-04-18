import 'package:buddyappfirebase/constants/route_names.dart';
import 'package:buddyappfirebase/locator.dart';
import 'package:buddyappfirebase/services/authentication_service.dart';
import 'package:buddyappfirebase/services/base_auth.dart';
import 'package:buddyappfirebase/services/dialog_service.dart';
import 'package:buddyappfirebase/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_model.dart';

// This is a class that allows to tell the user if the email
// entered in forget email was correct or not.
class PasswordViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future forgetLogin({
    @required String email,
  }) async {
    setBusy(true);

    var result =
        await _authenticationService.recoverPasswordWithEmail(email: email);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Email not found',
          description: 'General credential failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Credential Failure',
        description: result,
      );
    }
  }
}
