import 'dart:collection';
import 'package:buddyappfirebase/Authentication/screens/signup.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This class is responsible for teachers setup

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  TextEditingController className = new TextEditingController();
  TextEditingController classCode = new TextEditingController();
  bool execute = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpaceLarge,
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.blueAccent,
              padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
              onPressed: () {
                Navigator.pop(context); // Go back
              },
            ),
            verticalSpaceLarge,
            TextFormField(
              //Todo  Have to change the outline of textfield to blue
              controller: className,
              decoration: InputDecoration(
                  labelText: 'Class Name',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please make a class name.';
                }
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: classCode,
              decoration: InputDecoration(
                  labelText: 'Class Code',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please make a class code.';
                }
              },
              obscureText: false,
            ),
            verticalSpaceMedium,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text(
                    'CREATE CLASS',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  onPressed: () async {
                    updateInfo(); // Called
                    execute = true;
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Changed to UID
  // gets info from input and updates firestore
  void updateInfo() async {
    final HashMap<String, String> classes = HashMap();
    final userList = [];
    // adds class to classes collection
    final classDocument = await Firestore.instance
        .collection('classes')
        .document(className.text)
        .get();

    // checks to see if class already exists
    if (classDocument == null || !classDocument.exists) {
      // adds class for user
      classes[className.text] = classCode.text;
      Firestore.instance
          .collection('users')
          .document(SignUp.documentID) // changed
          .updateData({'classes': classes});
      Firestore.instance
          .collection('users')
          .document(SignUp.documentID) // changed
          .updateData({'userRole': 'teacher'});

      // adds class to classes collection
      Firestore.instance
          .collection('classes')
          .document(className.text)
          .setData({'code': classCode.text, 'users': userList});

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainHomeView()),
      );
    } else {
      AlertDialog inUse = AlertDialog(
        title: Text("Class name taken"),
        content: Text("Please try a different class name."),
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return inUse;
        },
      );
    }
  }
}
