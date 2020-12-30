/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Request page
  Description: Request Page Ui, currently not used


 */

import 'package:buddyappfirebase/Explore/screen/explore.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:buddyappfirebase/Message/screens/chatrooms.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestsView extends StatefulWidget {
  @override
  _RequestsViewState createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  int _currentIndex = 0;

  AppBar requestsAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        "Requests",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Scaffold body() {
    return Scaffold(
      appBar: requestsAppbar(),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}
