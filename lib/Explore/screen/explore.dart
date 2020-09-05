import 'package:buddyappfirebase/Explore/Widget/search_explore_card.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseMethods.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Message/helper/constants.dart';
import '../../Message/helper/helperfunctions.dart';
import '../../FirebaseData/firebaseReferences.dart';
import '../../Widget/progress.dart';
import '../../home/screens/MainHomeView.dart';
import '../../home/widgets/custom_drawers.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _profileImg = "";
  Map values = {};
  int amountOfClasses = 0;

  CupertinoTabBar tabBar() {
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

  @override
  void initState() {
    super.initState();
    _getUserProfileImg();
    _getClasses();
  }

  // This gets the profile Img url
  _getUserProfileImg() async {
    FirebaseMethods().getUserProfileImg();
    setState(() {
      _profileImg = FirebaseMethods.profileImgUrl.toString();
    });
  }

  // gets classes
  _getClasses() async {
    FirebaseMethods().getUserClasses();
    setState(() {
      values = FirebaseMethods.classValues;
      amountOfClasses = FirebaseMethods.amountOfClasses;
    });
  }

  SingleChildScrollView exploreBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(11.5),
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            new BorderSide(color: Colors.grey, width: 3)),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    hintText: "Ask a question",
                    suffixIcon: Icon(Icons.search)),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(11.5),
                child: Text(
                  "Good Morning",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Container(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: amountOfClasses,
                itemBuilder: (context, int index) {
                  String key = values.keys.elementAt(index);
               
                      return Row(
                        children: <Widget>[
                          classes(nameOfCourse: "$key"),
                        ],
                      );
                    
                  
                }),
          ),
          Container(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: amountOfClasses-2,
                itemBuilder: (context, int index) {
                  String key = values.keys.elementAt(index+2);  
                      return Row(
                        children: <Widget>[
                          classes(nameOfCourse: "$key"),
                        ],
                      );
                }),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(11.5),
                child: Text(
                  "Recommended",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Container(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: amountOfClasses,
                itemBuilder: (context, int index) {
                  String key = values.keys.elementAt(index);
               
                      return Row(
                        children: <Widget>[
                          classes(nameOfCourse: "$key"),
                        ],
                      );
                    
                  
                }),
          ),
          Container(
            height: 180,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: amountOfClasses-2,
                itemBuilder: (context, int index) {
                  String key = values.keys.elementAt(index+2);  
                      return Row(
                        children: <Widget>[
                          classes(nameOfCourse: "$key"),
                        ],
                      );
                }),
          ),
        ],
      ),
    );
  }

  AppBar exploreAppBar() {
    // App bar
    return AppBar(
        iconTheme: new IconThemeData(color: Colors.grey),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: new IconButton(
          icon: CircleAvatar(
            backgroundImage: NetworkImage("$_profileImg"),
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: Text(
          "Explore",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 31, color: Colors.black),
        ));
  }

  Scaffold exploreView() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: exploreAppBar(),
      drawer: CustomDrawers(),
      body: exploreBody(),
      bottomNavigationBar: tabBar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return exploreView();
  }

  Widget classes({String nameOfCourse}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ExploreCard(
        imgScr: 'assets/images/card_dog_1.png',
        title: nameOfCourse,
      ),
    );
  }
}
