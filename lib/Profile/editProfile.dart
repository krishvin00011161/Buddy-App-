import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/models/user.dart';
import 'package:buddyappfirebase/Widget/firebaseReferences.dart';
import 'package:buddyappfirebase/Widget/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  

  final String profileId;

  EditProfile({this.profileId});

  static String profileName = "";
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

  getUser() async {
    setState(() {
      isLoading = true;
    });
  }

  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null) ?  setState(() {
       _profileImg = doc.data["photoUrl"];
     }) : circularProgress();
     isLoading = false;
  }

   _getUserName() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null) ?  setState(() {
       _name = doc.data["userName"];
       EditProfile.profileName = doc.data["userName"];
     }) : circularProgress();
     isLoading = false;
  }

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

  updateData() async {
     _getUserName();
    Firestore.instance
          .collection('users')
          .document(Constants.myId) // changed
          .updateData({'userName': displayNameController.text});
    _getUserName();
  }

  

  @override
  Widget build(BuildContext context) {
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
      body: 
      isLoading
          ? circularProgress()
          : 
          ListView(
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
}