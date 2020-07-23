import 'package:flutter/material.dart';

import '../../login/ui/shared/ui_helpers.dart';
import '../services/auth.dart';

class Reset extends StatefulWidget {
  
  

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  TextEditingController emailEditingController = new TextEditingController();
  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  reset() async {
    if (formKey.currentState.validate()) {
      setState(() {
       isLoading = true;
      });

      await authService.
          resetPass(
            emailEditingController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
    );
  }
}