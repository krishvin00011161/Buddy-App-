import 'package:buddyappfirebase/chat/models/user_model.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/password_view.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:buddyappfirebase/login/ui/widgets/text_link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:buddyappfirebase/login/viewmodels/login_view_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:buddyappfirebase/login/ui/widgets/route_transition.dart';
import 'dart:async';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  static bool auth = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  GoogleSignIn googleSignIn = new GoogleSignIn();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  User currentUser;
  bool showSpinner = false; // A spinner that shows progress of login
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
      _navigationService.navigateTo(HomeViewRoute);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
      _navigationService.navigateTo(HomeViewRoute);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleLoginInSecret() async {
    auth = true;
  }

  bool isSignIn = false;

  bool isAuth = false;

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  Future<void> googleSignout() async {
    await _auth.signOut().then((onValue) {
      googleSignIn.signOut();
      setState(() {
        isSignIn = true;
      });
    });
  }

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
                      onPressed: () {
                        Navigator.of(context)
                            .push(Transition().createRoute(StartView()));
                      },
                    ),
                    verticalSpaceLarge,
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
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
                        isSignIn
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SignInButton(
                                      Buttons.Google,
                                      text: "Sign out with Google",
                                      onPressed: () {
                                        googleSignout();
                                      },
                                    ),
//                                CircleAvatar(
//                                  backgroundImage: NetworkImage(_user.photoUrl),
//                                ),
//                                //Text(_user.displayName),
//                                OutlineButton(
//                                  onPressed: () {
//                                    gooleSignout();
//                                  },
//                                  child: Text("Logout"),
//                                )
                                  ],
                                ),
                              )
                            : Center(
//                            child: OutlineButton(
//                              onPressed: () {
//                                handleSignIn();
//                                //_navigationService.navigateTo(HomeViewRoute);
//                              },
//                              child: Text("Sign In with Google"),
//                            ),
                                child: SignInButton(
                                  Buttons.Google,
                                  text: "Sign In with Google",
                                  onPressed: () {
                                    // Todo
                                    googleSignIn.signIn();
                                  },
                                ),
                              ),
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextLink(
                          'Forget Password',
                          onPressed: () {
                            // TODO: Handle navigation
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PasswordView(),
                                ));
                          },
                        )
                      ],
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
                          onPressed: () async {
                            try {
                              model.login(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              setState(() {
                                auth = true;
                              });
                              print(emailController.text);
                            } catch (e) {
                              print(e);
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
