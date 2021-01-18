import 'package:buddyappfirebase/GlobalWidget/CustomBottomNavigationBar.dart';
import 'package:buddyappfirebase/GlobalWidget/Progress.dart';
import 'package:buddyappfirebase/GlobalWidget/TimeStamp.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomAppBar.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:buddyappfirebase/Message/Screens/Chat.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar notificationAppBar() {
    // App bar
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.grey),
      backgroundColor: Colors.grey[100],
      elevation: 0,
      leading: IconButton(
        icon: CircleAvatar(
          backgroundImage: NetworkImage(Constants.myProfileImg),
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text(
        "Notification",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget todayList() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return ChatRoomsTile(
          userName: "Message from David",
          message: "What's up",
          time: 1610839587397,
          profileImg: "https://www.kindpng.com/picc/m/22-223965_no-profile-picture-icon-circle-member-icon-png.png",
        );
      }
    );
  }

  SingleChildScrollView body() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(11.5),
                child: Text(
                  "Today",
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
            height: 300,
            width: 390,
            child: todayList(),
          ),
        ],
      ),
    );
  }

  Scaffold notficationView() {
    return Scaffold(
      appBar: notificationAppBar(),
      drawer: CustomDrawers(),
      bottomNavigationBar: CustomBottomNavigationBar(),
      body: body(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return notficationView();
  }
}

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
                  backgroundImage: widget.profileImg != null
                      ? NetworkImage(widget.profileImg)
                      : circularProgress(), //Todo
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
