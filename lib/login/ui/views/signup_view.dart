import 'package:buddyappfirebase/chat/models/user_model.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:buddyappfirebase/login/ui/views/welcome_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:buddyappfirebase/login/viewmodels/signup_view_model.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/ui/widgets/route_transition.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final NavigationService _navigationService = locator<NavigationService>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  User currentUser;

  @override
  void initState() {
    super.initState();

    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
      Navigator.of(context).push(Transition().createRoute(WelcomeView()));
    }, onError: (err) {
      print('Error signing in: $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
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
                  Center(
                    child: SignInButton(
                      Buttons.Google,
                      text: "Sign Up with Google",
                      onPressed: () {
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
                      model.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      //createNormalUserInFirestore();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  createUserInFirestore() async {
    // 1) check if user exists in users collection in database (according to their id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page

      final FirebaseUser googleUser = await _auth.currentUser();
      final uid = googleUser.uid;
      // 3) get username from create account, use it to make new user document in users collection
      usersRef.document(user.id).setData({
        "id": uid,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "timestamp": timestamp
      });

      doc = await usersRef.document(user.id).get();
    }

    print(currentUser);
  }

  bool isAuth = false;

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }
}
