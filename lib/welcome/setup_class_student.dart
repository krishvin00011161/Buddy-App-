import 'dart:collection';
import 'package:buddyappfirebase/Authentication/screens/signup.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/ui_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// This is for students setup

class SetUpStudent extends StatefulWidget {
  @override
  _SetUpStudentState createState() => _SetUpStudentState();
}

class _SetUpStudentState extends State<SetUpStudent> {
  TextEditingController className = new TextEditingController();
  TextEditingController classCode = new TextEditingController();
  String documentID;

  getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

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
                  return 'Please make a class code.';
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
                    'JOIN CLASS',
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
                    updateInfo();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Needs to know how
  // changed to AuthService.idNew
  //gets info from input and updates firestore
  void updateInfo() async {
    final HashMap<String, String> classes = HashMap();

    // checks if class exists and if class code is correct
    DocumentReference documentReference =
        Firestore.instance.collection("classes").document(className.text);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists && datasnapshot.data['code'] == classCode.text) {
        // adds class for user
        classes[className.text] = classCode.text;
        Firestore.instance
            .collection('users')
            .document(SignUp.documentID) // changed AuthService.idNew
            .updateData({'classes': classes});
        Firestore.instance
            .collection('users')
            .document(SignUp.documentID) // changed
            .updateData({'userRole': 'student'});

        // adds user's id to the class's user array
        Firestore.instance
            .collection('classes')
            .document(className.text)
            .updateData({
          "users": FieldValue.arrayUnion([SignUp.documentID]) // changed
        }); // this works

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainHomeView()),
        );
      } else {
        AlertDialog inUse = AlertDialog(
          title: Text("Class not found"),
          content: Text(
              "Please make sure the class name and the class code are correct."),
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
