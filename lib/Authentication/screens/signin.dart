import 'package:buddyappfirebase/Authentication/screens/reset.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Authentication/services/auth.dart';
import 'package:buddyappfirebase/home/widgets/text_link.dart';
import 'package:buddyappfirebase/home/widgets/ui_helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../home/animation/FadeAnimation.dart';
import '../../home/screens/MainHomeView.dart';

// This class is responsible for Sign IN function
class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn(this.toggleView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Fields
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  AuthService authService = new AuthService();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;


  // Refer to auth.dart for documentation
  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
              emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null) {
          // If sign in with email is Successful
          QuerySnapshot userInfoSnapshot =
              await DatabaseMethods().getUserInfo(emailEditingController.text);

          // Saves userName, email, and Document ID
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.documents[0].data["userName"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.documents[0].data["userEmail"]);
          HelperFunctions.saveUserIDSharedPreference(
              userInfoSnapshot.documents[0].data['id']);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainHomeView()));
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    }
  }

  Scaffold body() {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceLarge,
                    verticalSpaceLarge,
                    FadeAnimation(
                      1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                        ),
                        controller: emailEditingController,
                      ),
                    ),
                    verticalSpaceSmall,
                    FadeAnimation(
                      1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                        ),
                        controller: passwordEditingController,
                        obscureText: true,
                      ),
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(
                          1.3,
                          TextLink(
                            'Forget Password',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reset()),
                              );
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
                        FadeAnimation(
                          1.3,
                          FlatButton(
                            child: Text(
                              'Log In',
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
                              signIn();
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
                        FadeAnimation(
                          1.3,
                          TextLink(
                            "Don't have an Account? Register Now",
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}
