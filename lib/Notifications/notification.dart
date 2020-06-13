import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:buddyappfirebase/message/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  NotificationView({Key key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawers(),
      bottomNavigationBar: CupertinoTabBar( // Code reuse make some class Reminder
          currentIndex: _currentIndex,
          activeColor: Theme.of(context).primaryColor,
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