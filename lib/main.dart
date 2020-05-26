import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/services/navigation_service.dart';
import 'package:buddyappfirebase/services/dialog_service.dart';
import 'login/ui/router.dart';
import 'managers/dialog_manager.dart';
import 'login/locator.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Compound',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Colors.redAccent, //Color.fromARGB(255, 9, 202, 172),
        accentColor: Color(0xFFFEF9EB), //Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: StartView(), //SignUpView
      onGenerateRoute: generateRoute,
    );
  }
}
