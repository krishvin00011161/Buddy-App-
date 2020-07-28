import 'package:buddyappfirebase/Notifications/notification.dart';
import 'package:buddyappfirebase/Profile/profile.dart';
import 'package:buddyappfirebase/Requests/requests.dart';
import 'package:buddyappfirebase/Settings/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Message/helper/authenticate.dart';

class CustomDrawers extends StatelessWidget {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text(
              "Guy",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            accountEmail: Text("Friends: 30"),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://img.pngio.com/user-logos-user-logo-png-1920_1280.png")),
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
            leading: Icon(Icons.mail),
            title: Text(
              "Requests",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigator push
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestsView()));
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
