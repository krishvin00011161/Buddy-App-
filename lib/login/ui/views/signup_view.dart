import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:buddyappfirebase/welcome/setup_class_student.dart';
import 'package:buddyappfirebase/welcome/welcome_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:buddyappfirebase/login/viewmodels/signup_view_model.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:buddyappfirebase/login/ui/widgets/route_transition.dart';



class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();

 GoogleSignInAccount id;
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();


  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  

  @override
  void initState() {
    super.initState();


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
                  labelText: 'FIRST NAME',
                ),
                controller: firstNameController,
              ),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'LAST NAME',
                ),
                controller: lastNameController,
              ),
              verticalSpaceSmall,
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
                      // .replaceAll(new RegExp(r"\s+\b|\b\s"), "") removes spaces
                      model.signUp(
                        email: emailController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "") ,
                        password: passwordController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "") ,
                        fullName: firstNameController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "") + ' ' + lastNameController.text.replaceAll(new RegExp(r"\s+\b|\b\s"), ""),
                      );
                      
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




}
