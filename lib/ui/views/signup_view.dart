import 'package:buddyappfirebase/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/ui/views/start_view.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:buddyappfirebase/viewmodels/signup_view_model.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:buddyappfirebase/ui/widgets/text_link.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buddyappfirebase/services/navigation_service.dart';
import 'package:buddyappfirebase/constants/route_names.dart';
import 'package:buddyappfirebase/locator.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final NavigationService _navigationService = locator<NavigationService>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  GoogleSignIn _googleSignIn = new GoogleSignIn();

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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StartView(),
                    ),
                  );
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
                        handleSignIn();
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

  Future<void> googleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = true;
      });
    });
  }
}

//class SignUpView extends StatelessWidget {
//  final emailController = TextEditingController();
//  final passwordController = TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return ViewModelProvider<SignUpViewModel>.withConsumer(
//      viewModel: SignUpViewModel(),
//      builder: (context, model, child) => Scaffold(
//        body: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 50.0),
//          child: Column(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.center,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Text(
//                'Sign Up',
//                style: TextStyle(
//                  fontSize: 38,
//                ),
//              ),
//              verticalSpaceLarge,
//              // TODO: Add additional user data here to save (episode 2)
//              InputField(
//                placeholder: 'Email',
//                controller: emailController,
//              ),
//              verticalSpaceSmall,
//              InputField(
//                placeholder: 'Password',
//                password: true,
//                controller: passwordController,
//                additionalNote: 'Password has to be a minimum of 6 characters.',
//              ),
//              verticalSpaceMedium,
//              Row(
//                mainAxisSize: MainAxisSize.max,
//                mainAxisAlignment: MainAxisAlignment.end,
//                children: [
//                  BusyButton(
//                    title: 'Sign Up',
//                    busy: model.busy,
//                    onPressed: () {
//                      // TODO: Perform firebase login here
//                      model.signUp(
//                          email: emailController.text,
//                          password: passwordController.text);
//                    },
//                  )
//                ],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
