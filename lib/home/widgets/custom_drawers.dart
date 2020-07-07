import 'package:buddyappfirebase/Notifications/notification.dart';
import 'package:buddyappfirebase/Profile/profile.dart';
import 'package:buddyappfirebase/Requests/requests.dart';
import 'package:buddyappfirebase/Settings/settings.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/views/login_view.dart';
import 'package:buddyappfirebase/login/ui/views/start_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class CustomDrawers extends StatelessWidget {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();


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
                  backgroundImage: NetworkImage("https://img.pngio.com/user-logos-user-logo-png-1920_1280.png")
                ),
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
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationView()));
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
                   Navigator.push(context, MaterialPageRoute(builder: (context) => RequestsView()));
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
                   Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsView()));
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
                  logout();
                  LoginView.loggedIn = false;
                },
              ),
            ],
          ),
        );
  }


  logout() {
    googleSignIn.signOut();
    _navigationService.navigateTo(StartViewRoute);
  }
}