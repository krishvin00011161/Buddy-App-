import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
      ),
      bottomNavigationBar: CupertinoTabBar( // Code reuse make some class Reminder
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
    ),
    );
  }
}
