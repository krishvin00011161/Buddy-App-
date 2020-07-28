import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/models/user.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Authentication/services/auth.dart';
import 'package:buddyappfirebase/home/widgets/text_link.dart';
import 'package:buddyappfirebase/home/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';
import '../../home/animation/FadeAnimation.dart';
import '../../welcome/welcome_view.dart';
import '../services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController firstNameEditingController =
      new TextEditingController();
  TextEditingController lastNameEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final DateTime timestamp = DateTime.now();

  signUp() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signUpWithEmailAndPassword(emailEditingController.text,
              passwordEditingController.text, User())
          .then((result) {
        if (result != null) {
          Map<String, String> userDataMap = {
            "id": AuthService.idNew,
            // "id2": AuthService.id,
            "userName": firstNameEditingController.text
                    .replaceAll(new RegExp(r"\s+\b|\b\s"), "") +
                ' ' +
                lastNameEditingController.text
                    .replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
            "userEmail": emailEditingController.text,
            "classes": "",
            "photoUrl":
                "https://img.pngio.com/user-logos-user-logo-png-1920_1280.png",
            "timeStamp": timestamp.toString(),
            "userRole": "",
          };

          databaseMethods.addUserInfo(userDataMap);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              firstNameEditingController.text
                      .replaceAll(new RegExp(r"\s+\b|\b\s"), "") +
                  ' ' +
                  lastNameEditingController.text
                      .replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
          HelperFunctions.saveUserEmailSharedPreference(
              emailEditingController.text);

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeView(),
              ));
        }
      });
    }
  }

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
                        controller: firstNameEditingController,
                      ),
                    ),
                    FadeAnimation(
                      1.3,
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                        controller: lastNameEditingController,
                      ),
                    ),
                    verticalSpaceSmall,
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
