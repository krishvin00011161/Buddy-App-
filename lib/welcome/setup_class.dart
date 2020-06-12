import 'dart:collection';

import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buddyappfirebase/login/services/firestoreService.dart';

class Setup extends StatefulWidget {
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  final NavigationService _navigationService = locator<NavigationService>();
  TextEditingController className = new TextEditingController();
  TextEditingController classCode = new TextEditingController();
  String documentID;

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
                    // createData();
                    updateInfo();
                    _navigationService.navigateTo(HomeViewRoute);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  // gets info from input and updates firestore
  void updateInfo() {
    final HashMap<String, String> classes = HashMap();
    classes[className.text] = classCode.text;
    Firestore.instance.collection('users').document(FirestoreService.id).updateData({'classes' : classes});
    Firestore.instance.collection('users').document(FirestoreService.id).updateData({'userRole' : 'teacher'});
  }
}