import 'package:buddyappfirebase/Explore/screen/explore.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestsView extends StatefulWidget {
  RequestsView({Key key}) : super(key: key);

  @override
  _RequestsViewState createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
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
}
