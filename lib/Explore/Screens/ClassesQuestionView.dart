/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: ClassQuestionView
  Description: Display questions of a certain class


 */

import 'package:buddyappfirebase/FirebaseData/firebaseMethods.dart';
import 'package:buddyappfirebase/Explore/Screens/CommentScreen.dart';
import 'package:buddyappfirebase/GlobalWidget/TextEditingControllers.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:buddyappfirebase/Message/screens/chatrooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Message/services/database.dart';
import '../../home/screens/MainHomeView.dart';
import 'explore.dart';

class ClassQuestionView extends StatefulWidget {
  final String className;
  ClassQuestionView({this.className});

  static bool like = false;
  @override
  _ClassQuestionViewState createState() => _ClassQuestionViewState();
}

class _ClassQuestionViewState extends State<ClassQuestionView> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchResultSnapshot;
  String _profileImg = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool haveUserSearched = false;
  int _currentIndex = 0;
  bool isSelected;
  bool like = false;
  QuerySnapshot searchLikeResultSnapshot;
  bool likeExists = false;

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

  // This searches for class questions
  initiateSearch() async {
    if (TextEditingControllers.searchEditingController.text.isEmpty) {
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

  searchIfLiked(String userId) async {
    if (ClassQuestionView.like == false) {
      // Checks if Like have been not pressed, Ex: If pressed why bother check, the liked data would be in database
      await databaseMethods
          .searchIfUserLiked(Constants.myId,
              userId) // Search If the user using this device have liked
          .then((snapshot) {
        searchLikeResultSnapshot = snapshot;
        if (searchLikeResultSnapshot != null) {
          // If the user did like, set var like Exists to true else false
          setState(() {
            likeExists = true;
          });
        } else {
          setState(() {
            likeExists = false;
          });
        }
      });
    }
  }

  liked(String userId, String questionId) async {
    searchIfLiked(userId); // Search If user has liked the post from other device

    if (likeExists == false) { // If the user has not liked at all
      Map<String, dynamic> like = {
        "userName": Constants.myName,
        "userId": Constants.myId,
        "timeStamp": DateTime.now().millisecondsSinceEpoch,
      };

      databaseMethods.addLike(questionId, like); // add like

      likeExists = true; // Make sure to know next time that like exists
    }
  }

  deleteLiked(String userId, String questionId) async {
    searchIfLiked(userId); // Check if the user like exists from another device
    if (likeExists == true) { // If the user did like on a another device
      databaseMethods.deleteLike(questionId); // delete the like

      likeExists = false; // Make sure to know next time that like does not exists
    }
  }

  // reads the time stamp of questions
  String readQuestionTimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = DateFormat.yMMMd().format(date);
    return time;
  }

  // this widget gets the list of questions
  Widget getQuestionList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Card(
                      elevation: 5.0,
                      shape: like == true
                          ? RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.redAccent[400], width: 2.0),
                            )
                          : RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.transparent, width: 2.0),
                            ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(searchResultSnapshot
                                  .documents[index].data["questionContent"]),
                              Text(searchResultSnapshot
                                  .documents[index].data["userName"]),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(readQuestionTimestamp(searchResultSnapshot
                                  .documents[index].data["timeStamp"])),
                              GestureDetector(
                                child: Text(
                                  "Comment",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CommentScreen(
                                              questionContent:
                                                  searchResultSnapshot
                                                      .documents[index]
                                                      .data["questionContent"],
                                              userName: searchResultSnapshot
                                                  .documents[index]
                                                  .data["userName"],
                                              questionId: searchResultSnapshot
                                                  .documents[index]
                                                  .data["questionId"],
                                            )),
                                  );
                                },
                              )
                            ],
                          ),
                        ]),
                      ),
                    ),
                    onDoubleTap: () {
                      // Tip! - If function is called after Setstate, it does not run
                      liked(
                          searchResultSnapshot.documents[index].data["userId"],
                          searchResultSnapshot
                              .documents[index].data["questionId"]);
                      setState(() {
                        like = true;
                        ClassQuestionView.like = true;
                      });
                    },
                    onTap: () {
                      deleteLiked(Constants.myId, searchResultSnapshot
                          .documents[index].data["questionId"]);

                      setState(() {
                        ClassQuestionView.like = false;
                        like = false;
                      });
                    },
                  ),
                ],
              );
            })
        : Container();
  }

  // responsible for the UI of AppBar
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
        child: Text(
          widget.className,
          style: TextStyle(color: Colors.black),
        ),
        onTap: () {
          initiateSearch();
        },
      ),
    );
  }

  // Responsible for the UI
  Scaffold body() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(),
      drawer: CustomDrawers(),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _currentIndex,
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
            getQuestionList(),
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
