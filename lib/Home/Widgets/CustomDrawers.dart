/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: CustomDrawers
  Description: Helps with importing Drawers


 */

import 'package:buddyappfirebase/Explore/Screens/Explore.dart';
import 'package:buddyappfirebase/FirebaseData/FirebaseReference.dart';
import 'package:buddyappfirebase/GlobalWidget/progress.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/Message/screens/chatrooms.dart';
import 'package:buddyappfirebase/Profile/profile.dart';
import 'package:buddyappfirebase/Settings/settings.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/ovalRightBorderClipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../GlobalWidget/authenticate.dart';


class CustomDrawers extends StatefulWidget {
  static final String path = "lib/src/pages/navigation/drawer2.dart";

  @override
  _CustomDrawersState createState() => _CustomDrawersState();
}

class _CustomDrawersState extends State<CustomDrawers> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Color primary = Colors.white;

  final Color active = Colors.grey.shade800;

  final Color divider = Colors.grey.shade600;

  String _profileImg = "";
  String _name;
  String _role;

  @override
  void initState() {
    super.initState();
    _getUserProfileImg();
    _getUserName();
    _getOccupation();
  }

  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null)
        ? setState(() {
            _profileImg = doc.data["photoUrl"];
          })
        : circularProgress();
  }

  _getUserName() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null)
        ? setState(() {
            _name = doc.data["userName"];
          })
        : circularProgress();
  }

  _getOccupation() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userRole"] != null)
        ? setState(() {
            _role = doc.data["userRole"];
          })
        : circularProgress();
  }

  @override
  Widget build(BuildContext context) {
    return _buildDrawer();
  }

  _buildDrawer() {
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {
                        _signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Authenticate()),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.lightBlue])),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage("$_profileImg"),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "$_name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "$_role",
                    style: TextStyle(color: active, fontSize: 16.0),
                  ),
                  SizedBox(height: 30.0),
                  _buildRow(Icons.home, "Home", "MainHomeView"),
                  _buildDivider(),
                  _buildRow(Icons.explore, "Explore", "ExploreView"),
                  _buildDivider(),
                  _buildRow(Icons.person_pin, "My profile", "ProfileView"),
                  _buildDivider(),
                  _buildRow(Icons.message, "Messages", "Chatrooms"),
                  _buildDivider(),
                  _buildRow(Icons.settings, "Settings", "Settings"),
                  _buildDivider(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(IconData icon, String title, String pages,
      {bool showBadge = false}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);
    return GestureDetector(
      onTap: () {
        if (pages == "MainHomeView") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainHomeView()),
          );
        } else if (pages == "ProfileView") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileView()),
          );
        } else if (pages == "Chatrooms") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoom()),
          );
        } else if (pages == "Settings") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsOnePage()),
          );
        } else if (pages == "ExploreView") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExplorePage()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Icon(
            icon,
            color: active,
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
        ]),
      ),
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
  }
}

