import 'dart:collection';

import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/GoogleFirestoreService.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buddyappfirebase/login/services/firestoreService.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login/models/user.dart';
import '../login/ui/views/signup_view.dart';
import '../login/ui/views/signup_view.dart';


// This is for teachers setup

class SetUpStudent extends StatefulWidget {
  @override
  _SetUpStudentState createState() => _SetUpStudentState();
}

class _SetUpStudentState extends State<SetUpStudent> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController className = new TextEditingController();
  TextEditingController classCode = new TextEditingController();
  String documentID;

  getUser() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      return user.uid;
  }


  // @override
  //  initState() async { 
  //   super.initState();
  //   userId = await getUser();
  //   print(userId);
  // }

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
            TextFormField( //Todo  Have to change the outline of textfield to blue
              controller: className,
              decoration: InputDecoration(
                labelText: 'Class Name',
                labelStyle: TextStyle(
                  color: Colors.blueAccent,
                )
              ),
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
                )
              ),
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
                    googleUpdateInfo(); 
                    updateInfo();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainHomeView()
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  //gets info from input and updates firestore
  void updateInfo() {
    final HashMap<String, String> classes = HashMap();
    classes[className.text] = classCode.text;
    Firestore.instance.collection('users').document(FirestoreService.id).updateData({'classes' : classes});
    Firestore.instance.collection('users').document(FirestoreService.id).updateData({'userRole' : 'Student'});
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  User currentUser;
  
  void googleUpdateInfo() async {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    final HashMap<String, String> classes = HashMap();
    classes[className.text] = classCode.text;
    print(user.id);
    //usersRef.document(SignUpView().id.toString()).updateData({'classes' : classes}); // bug always throw   Unhandled Exception: NoSuchMethodError: The getter 'id' was called on null
    //usersRef.document(SignUpView().id.toString()).updateData({'userRole' : "Student"});
    
  }
}