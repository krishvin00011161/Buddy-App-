/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: ChatRoom
  Description: This creates the cells of Chatrooms


 */

import 'package:buddyappfirebase/Explore/Screens/Explore.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseMethods.dart';
import 'package:buddyappfirebase/GlobalWidget/TimeStamp.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:buddyappfirebase/Message/screens/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../GlobalWidget/Progress.dart';
import '../../GlobalWidget/constants.dart';
import '../../home/screens/MainHomeView.dart';
import '../services/database.dart';
import 'chat.dart';

class ChatRoom extends StatefulWidget {
  final int index;
  ChatRoom({this.index});

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Stream chatRooms;
  int _currentIndex = 0;
  int chatCount = 0;
  QuerySnapshot searchResultSnapshot;

  // gets the info of user chats
  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print(
            "we got the data + ${chatRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  // seraches user by username
  searchUser(userName) async {
    await databaseMethods.searchByName(userName).then((snapshot) {
      searchResultSnapshot = snapshot;
      print("$searchResultSnapshot");
    });
  }

  @override
  void initState() {
    super.initState();
    getUserInfogetChats();
    
  }

  // Creates list of chatrooms buttons
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.documents[index].data['sendBy'],
                    chatRoomId:
                        snapshot.data.documents[index].data["chatRoomId"],
                    chatRoomName: snapshot.data.documents[index].data['chatRoomName'],
                    message: snapshot.data.documents[index].data["message"],
                    time: snapshot.data.documents[index].data["time"],
                    profileImg: snapshot.data.documents[index].data["image"],
                  );
                })
            : Container();
      },
    );
  }

  AppBar chatRoomAppbar() {
    // App bar
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.grey),
      backgroundColor: Colors.grey[100],
      elevation: 0,
      leading: new IconButton(
        icon: CircleAvatar(
          backgroundImage: NetworkImage(Constants.myProfileImg),
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text(
        "Messages",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Scaffold body() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: chatRoomAppbar(),
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
        child: chatRoomsList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.chat,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return body();
  }
}

// Responsible for creating Chat Tiles
class ChatRoomsTile extends StatefulWidget {
  final String userName;
  final String chatRoomId;
  final String chatRoomName;
  final String message;
  final int time;
  final String profileImg;

  ChatRoomsTile(
      {this.userName,
      @required this.chatRoomId,
      this.chatRoomName,
      this.message,
      this.time,
      this.profileImg});

  @override
  _ChatRoomsTileState createState() => _ChatRoomsTileState();
}

class _ChatRoomsTileState extends State<ChatRoomsTile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      chatRoomId: widget.chatRoomId,
                    )));
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
        child: Row(
          children: [
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage: 
                  widget.profileImg != null ?
                  NetworkImage(widget.profileImg) : circularProgress(), //Todo
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.userName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Text(
                        widget.message,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //SizedBox(width: 25.0),
            Column(
              children: <Widget>[
                Text(
                  TimeStamp().readQuestionTimeStampHours(widget.time),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 25.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
