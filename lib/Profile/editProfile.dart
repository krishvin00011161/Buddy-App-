/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Edit UserName
  Description: It is a page that helps update username


 */

import 'package:buddyappfirebase/FirebaseData/FirebaseReference.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/GlobalWidget/progress.dart';
import 'package:buddyappfirebase/Message/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final String profileId;
  static String profileName = "";

  EditProfile({this.profileId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool isLoading = false;
  User user;
  String _profileImg = "";
  String _name = "";

  @override
  void initState() {
    super.initState();
    getUser();
    _getUserProfileImg();
    _getUserName();
  }

  // gets the user
  getUser() async {
    setState(() {
      isLoading = true;
    });
  }

  // get user profile img
  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null)
        ? setState(() {
            _profileImg = doc.data["photoUrl"];
          })
        : circularProgress();
    isLoading = false;
  }

  // get user's username
  _getUserName() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null)
        ? setState(() {
            _name = doc.data["userName"];
            EditProfile.profileName = doc.data["userName"];
          })
        : circularProgress();
    isLoading = false;
  }

  // Build UI of tetfield
  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Display Name: $_name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
          ),
        )
      ],
    );
  }

  // function that updates username to database
  updateData() async {
    _getUserName();
    Firestore.instance.collection('users').document(Constants.myId) // changed
        .updateData({'userName': displayNameController.text});
    _getUserName();
  }

  Scaffold body() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          ),
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage("$_profileImg"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            buildDisplayNameField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          updateData();
                        },
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}
