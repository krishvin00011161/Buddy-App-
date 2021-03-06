/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: SignUp
  Description: Helps with SignUp


 */

import 'package:buddyappfirebase/GlobalWidget/TextEditingControllers.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/Home/Widgets/TextLink.dart';
import 'package:buddyappfirebase/Home/Widgets/UIHelpers.dart';
import 'package:buddyappfirebase/Message/models/user.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Authentication/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../home/animation/FadeAnimation.dart';
import '../../welcome/WelcomeView.dart';
import '../services/auth.dart';

// This class is responsible for Sign Up
class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  static String documentID = "";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final DateTime timestamp = DateTime.now();
  final questionList = ["Start Of Question"];

  // This function allows for Sign Up to work
  signUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(
              TextEditingControllers.emailEditingController.text,
              TextEditingControllers.passwordEditingController.text,
              User())
          .then((result) {
        if (result != null) {
          // if sign up works, then create a new user using these fields
          DocumentReference documentReference =
              Firestore.instance.collection('users').document();
          documentReference.setData({
            'id': documentReference.documentID,
            'userName': TextEditingControllers.firstNameEditingController.text,
            'userEmail': TextEditingControllers.emailEditingController.text,
            'classes': "",
            'photoUrl':
                "https://www.kindpng.com/picc/m/22-223965_no-profile-picture-icon-circle-member-icon-png.png",
            'timeStamp': timestamp.toString(),
            'userRole': "",
            'questions': questionList,
          });

          SignUp.documentID = documentReference.documentID;

          // Saves username, documentID or UserId, and user email

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(TextEditingControllers
                  .firstNameEditingController.text
                  .replaceAll(new RegExp(r"\s+\b|\b\s"), "") +
              ' ' +
              TextEditingControllers.lastNameEditingController.text
                  .replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
          HelperFunctions.saveUserEmailSharedPreference(
              TextEditingControllers.emailEditingController.text);
          HelperFunctions.saveUserIDSharedPreference(
              documentReference.documentID);
          HelperFunctions.saveUserProfileImagePreference(
              "https://www.kindpng.com/picc/m/22-223965_no-profile-picture-icon-circle-member-icon-png.png");

          // Pushes to Welcome view
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeView(),
              ));
        } else if (result == null) {
          // If Sign up did not work, go back to sign up screen
          AlertDialog inUse = AlertDialog(
            title: Text("Wrong Credentials"),
            content: Text(
                "Please try a different email or write a stronger password"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            actions: [
              FlatButton(
                child: new Text("Ok"),
                textColor: Colors.greenAccent,
                onPressed: () {
                  widget.toggleView();
                },
              ),
            ],
          );

          // show the dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return inUse;
            },
          );
        }
      });
    }
  }

  // Responsible for the UI
  Scaffold body() {
    return Scaffold(
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
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
                          labelText: 'First Name',
                        ),
                        controller:
                            TextEditingControllers.firstNameEditingController,
                      ),
                    ),
                    FadeAnimation(
                      1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        controller:
                            TextEditingControllers.lastNameEditingController,
                      ),
                    ),
                    verticalSpaceSmall,
                    FadeAnimation(
                      1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'EMAIL',
                        ),
                        controller:
                            TextEditingControllers.emailEditingController,
                      ),
                    ),
                    verticalSpaceSmall,
                    FadeAnimation(
                      1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'PASSWORD',
                        ),
                        controller:
                            TextEditingControllers.passwordEditingController,
                        obscureText: true,
                      ),
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(
                          1.3,
                          Text(
                            AuthService.errormessage,
                            style: TextStyle(color: Colors.red[500]),
                          ),
                        )
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeAnimation(
                          1.3,
                          TextLink(
                            'Already Have An Account',
                            onPressed: () {
                              widget.toggleView();
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
                              'SIGN UP',
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
                              signUp();
                            },
                          ),
                        ),
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
