import 'package:buddyappfirebase/FirebaseData/firebaseMethods.dart';import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Message/services/database.dart';
import '../../Message/views/chatrooms.dart';
import '../../home/screens/MainHomeView.dart';
import '../../home/widgets/custom_drawers.dart';
import 'explore.dart';

class ClassQuestionView extends StatefulWidget {
  final String className;
  ClassQuestionView({this.className});

  @override
  _ClassQuestionViewState createState() => _ClassQuestionViewState();
}

class _ClassQuestionViewState extends State<ClassQuestionView> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  String _profileImg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool haveUserSearched = false;
  int _currentIndex = 0;
  bool isSelected;

  @override
  void initState() {
    super.initState();
    initiateSearch();
    _getUserProfileImg();
  }

  // This gets the profile Img url
  _getUserProfileImg() async {
    FirebaseMethods().getUserProfileImg();
    setState(() {
      _profileImg = FirebaseMethods.profileImgUrl.toString();
    });
  }

  initiateSearch() async {
    if (searchEditingController.text.isEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchClassQuestions(widget.className)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  String readQuestionTimestamp(int timestamp) {
    var format = DateFormat('H:mm y');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = DateFormat.yMMMd().format(date);
    return time;
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(searchResultSnapshot.documents[index].data["questionContent"]),
                            Text(searchResultSnapshot.documents[index].data["userName"]),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(readQuestionTimestamp(searchResultSnapshot.documents[index].data["timeStamp"])),
                            Text("Comment", style: TextStyle(color: Colors.blue),)
                          ],
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            })
        : Container();
  }

  

  AppBar appBar() {
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
      
      title: GestureDetector(
        child: Text(widget.className, style: TextStyle(color: Colors.black),),
        onTap: () {
          initiateSearch();
        },
      ),
    );
  }

  Scaffold body() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(),
      drawer: CustomDrawers(),
      bottomNavigationBar: CupertinoTabBar(
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
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            userList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}
