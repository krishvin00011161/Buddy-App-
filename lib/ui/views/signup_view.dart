import 'package:buddyappfirebase/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:buddyappfirebase/viewmodels/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              ),
//              Text(
//                'Sign Up',
//                style: TextStyle(
//                  fontSize: 38,
//                ),
//              ),
              verticalSpaceLarge,
              // TODO: Add additional user data here to save (episode 2)
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
//              InputField(
//                placeholder: 'Password',
//                password: true,
//                controller: passwordController,
//                additionalNote: 'Password has to be a minimum of 6 characters.',
//              ),
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
