
import 'package:buddyappfirebase/login/ui/views/login_view.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:buddyappfirebase/message/conversation_screen.dart';
import 'package:buddyappfirebase/message/message.dart';
import 'package:buddyappfirebase/testMessage/helper/authenticate.dart';
import 'package:buddyappfirebase/testMessage/helper/helperfunctions.dart';
import 'package:buddyappfirebase/testMessage/views/chatrooms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/services/dialog_service.dart';
import 'home/screens/MainHomeView.dart';
import 'login/ui/router.dart';
import 'login/managers/dialog_manager.dart';
import 'login/locator.dart';
import 'package:flutter/cupertino.dart';




void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoginView auth = new LoginView();

  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        accentColor: Color(0xff007EF4),
        fontFamily: "OverpassRegular",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
          : Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
    );
  }

  MaterialApp mainBody() {
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
        primaryColor: Colors.grey, //Colors.redAccent, //Color.fromARGB(255, 9, 202, 172),
        accentColor: Color(0xFFFEF9EB), //Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
        ),
      ),
      home: userIsLoggedIn != null ?  userIsLoggedIn ? ChatRoom() : Authenticate()
          : Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
       // Checks if the user is logged in, if not make sure to navigate to Login
      onGenerateRoute: generateRoute,
    );
  }

  // MaterialApp mainBody() {
  //    return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Compound',
  //     builder: (context, child) => Navigator(
  //       key: locator<DialogService>().dialogNavigationKey,
  //       onGenerateRoute: (settings) => MaterialPageRoute(
  //           builder: (context) => DialogManager(child: child)),
  //     ),
  //     navigatorKey: locator<NavigationService>().navigationKey,
  //     theme: ThemeData(
  //       primaryColor: Colors.grey, //Colors.redAccent, //Color.fromARGB(255, 9, 202, 172),
  //       accentColor: Color(0xFFFEF9EB), //Color.fromARGB(255, 26, 27, 30),
  //       textTheme: Theme.of(context).textTheme.apply(
  //         fontFamily: 'Open Sans',
  //       ),
  //     ),
  //     home: StartView(),
  //      // Checks if the user is logged in, if not make sure to navigate to Login
  //     onGenerateRoute: generateRoute,
  //   );
  // }
}
