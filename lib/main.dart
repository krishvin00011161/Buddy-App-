import 'package:buddyappfirebase/chat/screens/home_screen.dart';
import 'package:buddyappfirebase/ui/views/start_view.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/services/navigation_service.dart';
import 'package:buddyappfirebase/services/dialog_service.dart';
import 'managers/dialog_manager.dart';
import 'ui/router.dart';
import 'locator.dart';
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

//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  FirebaseAuth _auth = FirebaseAuth.instance;
//  FirebaseUser _user;
//
//  GoogleSignIn _googleSignIn = new GoogleSignIn();
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//          appBar: AppBar(
//            title: Text("google Authentication"),
//          ),
//          body: isSignIn
//              ? Center(
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      CircleAvatar(
//                        backgroundImage: NetworkImage(_user.photoUrl),
//                      ),
//                      Text(_user.displayName),
//                      OutlineButton(
//                        onPressed: () {
//                          gooleSignout();
//                        },
//                        child: Text("Logout"),
//                      )
//                    ],
//                  ),
//                )
//              : Center(
//                  child: OutlineButton(
//                    onPressed: () {
//                      handleSignIn();
//                    },
//                    child: Text("SignIn with Goolge"),
//                  ),
//                )),
//    );
//  }
//
//  bool isSignIn = false;
//
//  Future<void> handleSignIn() async {
//    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//    GoogleSignInAuthentication googleSignInAuthentication =
//        await googleSignInAccount.authentication;
//
//    AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleSignInAuthentication.idToken,
//        accessToken: googleSignInAuthentication.accessToken);
//
//    AuthResult result = (await _auth.signInWithCredential(credential));
//
//    _user = result.user;
//
//    setState(() {
//      isSignIn = true;
//    });
//  }
//
//  Future<void> gooleSignout() async {
//    await _auth.signOut().then((onValue) {
//      _googleSignIn.signOut();
//      setState(() {
//        isSignIn = true;
//      });
//    });
//  }
//}
