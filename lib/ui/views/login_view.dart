import 'package:buddyappfirebase/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:buddyappfirebase/viewmodels/login_view_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buddyappfirebase/services/navigation_service.dart';
import 'package:buddyappfirebase/locator.dart';
import 'package:buddyappfirebase/constants/route_names.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpaceLarge,
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.orangeAccent,
                  padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
                ),
                verticalSpaceLarge,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
//                    focusedBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(color: Colors.cyan),
//                    ),
                  ),
                  controller: emailController,
                ),
                verticalSpaceSmall,
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                  ),
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpaceMedium,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.orangeAccent,
                      padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      onPressed: () {
                        model.login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                    )
//                    BusyButton(
//                      title: 'Login',
//                      busy: model.busy,
//                      onPressed: () {
//                        model.login(
//                          email: emailController.text,
//                          password: passwordController.text,
//                        );
//                      },
//                    )
                  ],
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isSignIn
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: NetworkImage(_user.photoUrl),
                                ),
                                Text(_user.displayName),
                                OutlineButton(
                                  onPressed: () {
                                    gooleSignout();
                                  },
                                  child: Text("Logout"),
                                )
                              ],
                            ),
                          )
                        : Center(
                            child: OutlineButton(
                              onPressed: () {
                                handleSignIn();
                                //_navigationService.navigateTo(HomeViewRoute);
                              },
                              child: Text("Sign In with Goolge"),
                            ),
                          ),
                  ],
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextLink(
                      'Create an Account if you\'re new.',
                      onPressed: () {
                        // TODO: Handle navigation
                      },
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  bool isSignIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    setState(() {
      isSignIn = true;
      _navigationService.navigateTo(HomeViewRoute);
    });
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = true;
      });
    });
  }
}
