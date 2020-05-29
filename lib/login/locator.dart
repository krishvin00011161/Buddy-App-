import 'package:buddyappfirebase/login/services/authentication_service.dart';
import 'package:buddyappfirebase/login/services/firestoreService.dart';
import 'package:get_it/get_it.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/services/dialog_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() { // Locate where it register
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}