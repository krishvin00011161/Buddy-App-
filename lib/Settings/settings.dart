/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Settings Page
  Description: Responsible for the UI and Function of Settings


 */

import 'package:buddyappfirebase/Authentication/screens/reset.dart';
import 'package:buddyappfirebase/FirebaseData/FirebaseReference.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/GlobalWidget/progress.dart';
import 'package:buddyappfirebase/GlobalWidget/CustomBottomNavigationBar.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingsOnePage extends StatefulWidget {
  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  bool _dark;
  String _name = "";
  String _profileImg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _dark = false;
    _getUserProfileImg();
    _getUserName();
  }

  // responsible for dark mode
  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }

  // gets the profile img
  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null)
        ? setState(() {
            _profileImg = doc.data["photoUrl"];
          })
        : circularProgress();
  }

  // gets user name
  _getUserName() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null)
        ? setState(() {
            _name = doc.data["userName"];
          })
        : circularProgress();
  }

  // Makes it available to open links in Safari or Chrome
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        //forceWebView: ,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  int selectedIndex = 0;

  // responsible for home UI
  Theme homeBody() {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawers(),
        bottomNavigationBar: CustomBottomNavigationBar(),
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          leading: new IconButton(
            icon: CircleAvatar(
              backgroundImage: NetworkImage("$_profileImg"),
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    color: Colors.lightBlue,
                    child: ListTile(
                      onTap: () {
                        //open edit profile
                      },
                      title: Text(
                        "$_name",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage("$_profileImg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(
                            Icons.lock_outline,
                            color: Colors.lightBlue,
                          ),
                          title: Text("Change Password"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change password
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Reset()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.lock,
                            color: Colors.lightBlue,
                          ),
                          title: Text("Privacy Policy"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            launchInBrowser(
                                "https://docs.google.com/document/d/1TAqTE7MBzuIagISHHzjGxSHoY1z884LXR3iGIojz1sA/edit");
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Notification Settings",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: _receivedNotification,
                    title: Text("Received notification"),
                    onChanged: (value) => setState(() {
                      _receivedNotification = value;
                    }),
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: _receivedNewsLetter,
                    title: Text("Received newsletter"),
                    onChanged: (value) => setState(() {
                      _receivedNewsLetter = value;
                    }),
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: _receivedOfferNotification,
                    title: Text("Received Offer Notification"),
                    onChanged: (value) => setState(() {
                      _receivedOfferNotification = value;
                    }),
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: _receivedAppUpdates,
                    title: Text("Received App Updates"),
                    onChanged: (value) => setState(() {
                      _receivedAppUpdates = value;
                    }),
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _receivedNotification = false;
  bool _receivedNewsLetter = false;
  bool _receivedOfferNotification = false;
  bool _receivedAppUpdates = false;

  // Function that builds dividers
  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return homeBody();
  }
}
