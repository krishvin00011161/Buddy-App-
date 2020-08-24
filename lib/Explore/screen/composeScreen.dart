import 'dart:collection';

import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Widget/firebaseReferences.dart';
import 'package:buddyappfirebase/Widget/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComposeScreen extends StatefulWidget {
  ComposeScreen({Key key}) : super(key: key);

  @override
  _ComposeScreenState createState() => _ComposeScreenState();
}

class _ComposeScreenState extends State<ComposeScreen> {
  TextEditingController composeEditingController = new TextEditingController();

  String _profileImg;
  String _name;
  final DateTime timestamp = DateTime.now();

  @override
  void initState() { 
    super.initState();
    _getUserProfileImg();
    _getUserName();
  }

  // gets the profile
  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null) ?  setState(() {
       _profileImg = doc.data["photoUrl"];
     }) : circularProgress();
  }

  // gets the username
  _getUserName() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null) ?  setState(() {
       _name = doc.data["userName"];
     }) : circularProgress();
  }

  
  final HashMap<String, String> totalAnswer = HashMap();
  final userList = [];


    // Creates the question
  _createQuestion() async { // figure out how to deal with multiple answers later.
    DocumentReference documentReference = Firestore.instance.collection('questions').document();
          documentReference.setData({
          'question' : composeEditingController.text,
          'id': documentReference.documentID, 
          'userId' : Constants.myId,
          'userName': _name,
          'timeStamp': timestamp.toString(),
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.cancel,
            color: Colors.lightBlue[200], //Color(0x5EC4F2),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.lightBlue[200],
            ),
            onPressed: () {
              _createQuestion();
              print(composeEditingController.text);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "$_profileImg"),
                  ),
                ),
                SizedBox(
                  width: 3,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What's Happening?",
                      focusColor: Colors.black,
                    ),
                    controller: composeEditingController,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
