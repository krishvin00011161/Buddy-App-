import 'package:buddyappfirebase/home/animation/FadeAnimation.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/password_view.dart';
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


import '../../../Authentication/services/auth.dart';




class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();

  static bool loggedIn = false;
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

  bool showSpinner = false; // A spinner that shows progress of login
  String email = "";
  String password = "";

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

 



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
                    FadeAnimation(1.3,
                       IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.orangeAccent,
                        padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    verticalSpaceLarge,
                    FadeAnimation(1.3,
                       TextFormField(
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                        ),
                        controller: emailController,
                      ),
                    ),
                    verticalSpaceSmall,
                    FadeAnimation(1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                        ),
                        controller: passwordController,
                        obscureText: true,
                      ),
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(1.3,
                          TextLink(
                            'Forget Password',
                            onPressed: () {
                              // TODO: Handle navigation
                            //  widget.toggleView();
                            },
                          ),
                        )
                      ],
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(1.3,
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
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ));
  }
}
