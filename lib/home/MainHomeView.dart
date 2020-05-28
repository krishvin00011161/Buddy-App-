import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:flutter/material.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainHomeView extends StatefulWidget {
  @override
  _MainHomeViewState createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();

  Scaffold mainHomeView() {
    // The home view in 1st tab bar
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              alignment: Alignment.centerLeft,
              icon: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png",
                ),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Guy"),
              accountEmail: Text("k@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png"),
              ),
            )
          ],
        ),
      ),
    );
  }

  MaterialApp homeMainScreen() {
    return MaterialApp(
      home: FloatingSearchBar.builder(
        itemCount: 0,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        trailing: Icon(Icons.search),
        drawer: Drawer(
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
                      "https://cdn4.iconfinder.com/data/icons/avatars-21/512/avatar-circle-human-male-3-512.png"),
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
                },
              ),
            ],
          ),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Ask a Question...",
        ),
      ),
    );
  }

  logout() {
    googleSignIn.signOut();
    _navigationService.navigateTo(StartViewRoute);
  }

  @override
  Widget build(BuildContext context) {
    return homeMainScreen();
  }
}
