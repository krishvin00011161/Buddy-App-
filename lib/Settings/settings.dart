import 'package:buddyappfirebase/Authentication/screens/reset.dart';
import 'package:buddyappfirebase/Explore/screen/explore.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseReferences.dart';
import 'package:buddyappfirebase/Global%20Widget/progress.dart';
import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link/link.dart';

class SettingsOnePage extends StatefulWidget {
  @override
  _SettingsOnePageState createState() => _SettingsOnePageState();
}

class _SettingsOnePageState extends State<SettingsOnePage> {
  bool _dark;
  String _name = "";
  String _profileImg = "";
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _dark = false;
    _getUserProfileImg();
    _getUserName();
  }

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

  

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: CustomDrawers(),
        bottomNavigationBar: CupertinoTabBar(
          // Code reuse make some class Reminder
          currentIndex: _currentIndex,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: _currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              title: Text(""),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat,
                  color: _currentIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey),
              title: Text(""),
            )
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainHomeView()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatRoom()),
              );
            }
          },
        ),
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
                      trailing: Icon(
                        Icons.edit,
                        color: Colors.white,
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
                              MaterialPageRoute(
                                  builder: (context) => Reset()),
                            );
                          },
                        ),
                        _buildDivider(),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: Colors.lightBlue,
                          ),
                          title: Text("Change Location"),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            //open change location
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
                            Link(
                              child: Text("Private Policy"),
                              url:
                                  'https://docs.google.com/document/d/1TAqTE7MBzuIagISHHzjGxSHoY1z884LXR3iGIojz1sA/edit',
                            );
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
                    value: true,
                    title: Text("Received notification"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Received newsletter"),
                    onChanged: null,
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received Offer Notification"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.lightBlue,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Received App Updates"),
                    onChanged: null,
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
}
