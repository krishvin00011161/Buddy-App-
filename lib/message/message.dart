import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Explore/explore.dart';
import '../home/screens/MainHomeView.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int _currentIndex = 0;

  CupertinoTabBar tabBar() {
    return CupertinoTabBar( // Code reuse make some class Reminder
          currentIndex: _currentIndex,
          //activeColor: Theme.of(context).primaryColor,
          items: [
          BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: _currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
          ),
          title: Text(""),
          
          ),
          BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: _currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey
          ),
          title: Text(""),
          ),
          BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey
          ),
          title: Text(""),
          )
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainHomeView()),
          );

          
      } else if (index == 1) {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExplorePage()),
          );
      } else {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen()),
          );
      }
      },
    );
  }

  Scaffold messageView() {
    return Scaffold(
      appBar:messageAppBar(),
      bottomNavigationBar: tabBar(),
    );
  }

  AppBar messageAppBar() {
    return AppBar(
        title: Text("Message"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return messageView();
  }
}
