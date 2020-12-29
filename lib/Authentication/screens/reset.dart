import 'package:buddyappfirebase/home/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';
import '../services/auth.dart';


// This class is responsible for Resetting password
class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController emailEditingController = new TextEditingController();
  AuthService authService = new AuthService();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  
  // The main Functionality of Reset
  reset() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      // Refer Auth.dart for Documentation
      await authService
          .resetPass(emailEditingController.text)
          .then((result) async {
        Navigator.pop(context);
      });
    }
  }

  // responsible for the UI of the Page
  Scaffold _body() {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 50),
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
                  Navigator.pop(context);
                },
              ),
              verticalSpaceMedium,
              Text("Reset Password Email"),
              verticalSpaceSmall,
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                ),
                controller: emailEditingController,
              ),
              verticalSpaceSmall,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[],
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    child: Text(
                      'Reset Password',
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
                      reset();
                    },
                  ),
                  verticalSpaceMedium,
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
    return _body();
  }
}
