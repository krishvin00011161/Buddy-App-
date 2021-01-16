import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import '../Explore/Screens/Explore.dart';
import '../Home/Screens/MainHomeView.dart';
import '../Home/Screens/composeScreen.dart';
import '../Message/Screens/ChatRooms.dart';
import '../Notification/NotificationPage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FFNavigationBar(
      theme: FFNavigationBarTheme(
        barBackgroundColor: Colors.white,
        selectedItemBorderColor: Colors.yellow,
        selectedItemBackgroundColor: Colors.blueAccent,
        selectedItemIconColor: Colors.white,
        selectedItemLabelColor: Colors.black,
      ),
      selectedIndex: selectedIndex,
      onSelectTab: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainHomeView()),
          );
        } else if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationPage()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComposeScreen()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExplorePage()),
          );
        } else if (index == 4) {
          //Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, reverseDuration: Duration(milliseconds: 300), child: SettingsOnePage()));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoom()),
          );
        }
        setState(() {
          selectedIndex = index;
        });
      },
      items: [
        FFNavigationBarItem(
          iconData: Icons.home,
          label: 'Home',
        ),
        FFNavigationBarItem(
          iconData: Icons.notifications,
          label: 'Notification',
        ),
        FFNavigationBarItem(
          iconData: Icons.add,
          label: 'Add',
        ),
        FFNavigationBarItem(
          iconData: Icons.explore,
          label: 'Explore',
        ),
        FFNavigationBarItem(
          iconData: Icons.message,
          label: 'Messages',
        ),
      ],
    );
  }
}
