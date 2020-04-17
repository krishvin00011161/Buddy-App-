import 'package:buddyappfirebase/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:buddyappfirebase/ui/views/login_view.dart';
import 'package:buddyappfirebase/constants/route_names.dart';
import 'package:buddyappfirebase/services/base_auth.dart';
import 'package:buddyappfirebase/ui/widgets/text_link.dart';

class PasswordView extends StatefulWidget {
  @override
  _PasswordViewState createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  final emailController = TextEditingController();
  String errorMessage;

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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginView(),
                  ),
                );
              },
            ),
            verticalSpaceMedium,
            Text("Reset Password Email"),
            verticalSpaceLarge,
            TextFormField(
              decoration: InputDecoration(
                labelText: 'EMAIL',
              ),
              controller: emailController,
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
                    try {
                      Auth().resetPassword(emailController.text);
                      print(emailController.text);
                    } catch (e) {
                      print(e);
                      errorMessage = "Incorrect Email";
                    }
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
