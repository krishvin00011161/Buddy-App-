import 'dart:convert';
import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/home/homeUser.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link/link.dart';

class SettingsView extends StatefulWidget {
  SettingsView({Key key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: settingAppbar(),
      drawer: CustomDrawers(),
      body: Column(
        children: <Widget>[
          SwitchListTile(
            value: false,
            activeColor: Colors.green[500],
            title: Text("Notifications"),
            onChanged: (val) {},
          ),
          SwitchListTile(
            value: false,
            activeColor: Colors.green[500],
            title: Text("Dark Mode"),
            onChanged: (bool value) {
              setState(() {
//                var settingsDarkViewState = _SettingsDarkViewState();
              });
            },
          ),
          ExpansionTile(
            title: Text("Private Policy Link Below"),
            children: <Widget>[
              Link(
                child: Text("Private Policy"),
                url:
                    'https://docs.google.com/document/d/1TAqTE7MBzuIagISHHzjGxSHoY1z884LXR3iGIojz1sA/edit',
              )
            ],
          ),
        ],
      ),
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
    );
  }

  AppBar settingAppbar() {
    bool isSearching = false;

    AutoCompleteTextField searchTextField;
    GlobalKey<AutoCompleteTextFieldState<HomeUser>> key = new GlobalKey();

    List<HomeUser> loadUsers(String jsonString) {
      final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
      return parsed.map<HomeUser>((json) => HomeUser.fromJson(json)).toList();
    }

    List<HomeUser> users = new List<HomeUser>();
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        "Settings",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
