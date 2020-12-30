import 'package:buddyappfirebase/Message/screens/chatrooms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Explore/screen/explore.dart';
import '../home/screens/MainHomeView.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    Key key,
    @required int currentIndex,
   
  }) : _currentIndex = currentIndex, super(key: key);

  final int _currentIndex;


  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      // Code reuse make some class Reminder
      currentIndex: _currentIndex,
      //activeColor: Theme.of(context).primaryColor,
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
    );
  }
}