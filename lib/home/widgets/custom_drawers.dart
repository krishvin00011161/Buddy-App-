import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Notifications/notification.dart';
import 'package:buddyappfirebase/Profile/profile.dart';
import 'package:buddyappfirebase/Requests/requests.dart';
import 'package:buddyappfirebase/Settings/settings.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseReferences.dart';
import 'package:buddyappfirebase/Widget/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Message/helper/authenticate.dart';

class CustomDrawers extends StatefulWidget {
  @override
  _CustomDrawersState createState() => _CustomDrawersState();
}
final usersRef = Firestore.instance.collection('users');

class _CustomDrawersState extends State<CustomDrawers> {
final FirebaseAuth _auth = FirebaseAuth.instance;
  String _profileImg = "";
  String _name;

  @override
  void initState() { 
    super.initState();
    _getUserProfileImg();
    _getUserName();
  }

  
  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null) ?  setState(() {
       _profileImg = doc.data["photoUrl"];
     }) : circularProgress();
     
  }

  _getUserName() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc = await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null) ?  setState(() {
       _name = doc.data["userName"];
     }) : circularProgress();
     
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(
              "$_name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            accountEmail: Text("Friends: 30"),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "$_profileImg")),
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text(
              "Profile",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigator push
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileView()));
            },
          ),
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text(
              "Notification",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigator push
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationView()));
            },
          ),
         
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              "Setting",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigator push
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsView()));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.black,
          ),
          ListTile(
            title: Text(
              "Feedback",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigator push
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            title: Text(
              "Log out",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigator push
              _signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Authenticate()),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
  }
}
