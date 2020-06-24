import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home/screens/MainHomeView.dart';
import '../message/message.dart';


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {

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


  ListView exploreBody() {
    return ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(11.5),
            child: TextField(
              onChanged: (val){

                //findQuestion(val);
              },
              decoration: InputDecoration(
                prefix:IconButton(
                  color:Colors.black,
                  icon:Icon(Icons.arrow_back),
                  iconSize: 20.0,
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                contentPadding: EdgeInsets.only(left: 26.5),
                hintText:'Search Question',
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0))),
                ),
              ),
              ],
            );
  }
  Scaffold exploreView() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore page"),
      ),
      body: exploreBody(),
      bottomNavigationBar: tabBar(),
      );
  }
  

  @override
  Widget build(BuildContext context) {
    return exploreView();
  }
}
