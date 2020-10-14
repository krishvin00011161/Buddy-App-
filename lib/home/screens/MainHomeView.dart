import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/helper/theme.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Message/views/chat.dart';
import 'package:buddyappfirebase/home/screens/composeScreen.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseMethods.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/home/animation/FadeAnimation.dart';
import 'package:buddyappfirebase/home/screens/searchHome.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Explore/screen/explore.dart';
import '../../Message/services/database.dart';
import '../../Message/services/database.dart';
import '../../Message/views/chatrooms.dart';
import '../../Profile/profile.dart';

// This class is responsible for the home page
class MainHomeView extends StatefulWidget {
  // Getting fed the chatroomId Data from Search.dart
  final String chatRoomId;
  MainHomeView({this.chatRoomId});

  @override
  _MainHomeViewState createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Stream chatRooms;
  String _profileImg = "";
  String _name = "";
  List questionValues = [];
  int amountOfQuestions = 0;
  Stream<QuerySnapshot> chats; // Data of all chat
  String message;

  @override
  void initState() {
    super.initState();
    _getUserProfileImg();
    _getUserName();
    _getUserQuestion();
    getUserInfogetChats(); // getting the user info of chat
    // I have a bug, I am trying to get the last chat of from a ChatRoom
    // This code down here gets the Chat data from a certain chat room.
    // This code needs to be ran multiple times if we want to show the last message from multiple chatrooms
    // I am not sure how to get mutliple chatroomid and Run this piece of code.
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    chatMessages();
    initiateSearch();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
  }

  // This gets the profile Img url
  _getUserProfileImg() async {
    FirebaseMethods().getUserProfileImg();
    setState(() {
      _profileImg = FirebaseMethods.profileImgUrl.toString();
    });
  }

  // gets user name
  _getUserName() async {
    FirebaseMethods().getUserName();
    setState(() {
      _name = FirebaseMethods.userName.toString();
    });
  }

  // gets question
  _getUserQuestion() async {
    FirebaseMethods().getUserQuestions();
    setState(() {
      questionValues = FirebaseMethods.questionValues.toList();
      amountOfQuestions = FirebaseMethods.amountOfQuestions.toInt();
    });
  }

  String readTimestamp(int timestamp) {
    // This converts timestamp in a human readable form
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }
    return time;
  }

  String readQuestionTimestamp(int timestamp) {
    var format = DateFormat('H:mm y');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var time = '';
    time = DateFormat.yMMMd().format(date);
    return time;
  }

  Widget chatMessages() {
    // Gets the chat? I am not quite sure
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  setState(() {
                    message = snapshot.data.documents[index].data["message"];
                  });
                })
            : Container();
      },
    );
  }

  TextEditingController searchEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  bool haveUserSearched = false;
  QuerySnapshot searchResultSnapshot;

  initiateSearch() async {
    if (searchEditingController.text.isEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchMyQuestions("Tim").then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return Row(
                children: <Widget>[
                  questions(
                      questionContent: searchResultSnapshot
                          .documents[index].data["questionContent"], 
                  timestamp: searchResultSnapshot
                          .documents[index].data["timeStamp"],
                  likes: searchResultSnapshot.documents[index].data["like"],
                  comments: searchResultSnapshot.documents[index].data['reply'],

                          
                 ),
                  
                          
                ],
              );
            })
        : Container();
  }

  Widget userTile(String content) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Divider(
                height: 3.0,
              )
            ],
          ),
        ],
      ),
    );
  }

  Scaffold home() {
    // This is responsible for the Home View
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[100],
      appBar: homeAppBar(),
      drawer: CustomDrawers(),
      body: homeBody(),
      bottomNavigationBar: tabBar(),
    );
  }

  CupertinoTabBar tabBar() {
    return CupertinoTabBar(
      // Code reuse make some class Reminder

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
    );
  }

  AppBar homeAppBar() {
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
      title: Container(
        width: 310,
        child: TextField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: new BorderSide(color: Colors.grey, width: 3)),
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              hintText: "Find User",
              suffixIcon: Icon(Icons.search)),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SearchHome()));
          },
        ),
      ),
    );
  }

  int numberOfGroups = 0;

  SingleChildScrollView homeBody() {
    // Anything body related
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Groups",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 35),
                      maxLines: 1,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                      child: Text(
                        "See all >",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatRoom()));
                      }),
                ]),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.4,
                  Container(
                      // Important ****
                      height: 280,
                      child: StreamBuilder(
                          stream: chatRooms,
                          initialData: "",
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? ListView.builder(
                                    // This Builder builds the yellow rectangles. Gets the data from Chatrooms
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.documents.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return groups(
                                        title: snapshot.data.documents[index]
                                            .data['chatRoomName']
                                            .toString(),
                                        messageContent:
                                            Chat.lastChat.toString(),
                                        time: readTimestamp(Chat.lastTime),
                                        chatRoomId: snapshot
                                            .data
                                            .documents[index]
                                            .data["chatRoomId"],
                                        name: snapshot.data.documents[index]
                                            .data['chatRoomId']
                                            .toString()
                                            .replaceAll("_", "")
                                            .replaceAll(Constants.myName, ""),
                                      );
                                    })
                                : groups(title: "Hello");
                          })),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Questions",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 35),
                        )),
                    Spacer(),
                    GestureDetector(
                      child: Text(
                        "See all >",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView()));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.4,
                  Container(
                    height: 225,
                    child: userList(),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // This Widget creates the Yellow rectangular tiles
  Widget groups(
      {String title,
      String messageContent,
      String chatRoomId,
      String photoUrl,
      String name,
      String time}) {
    // Makes Rectangles belongs in the groups section
    return AspectRatio(
      aspectRatio: 10 / 9.3,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chat(
                        chatRoomId: chatRoomId,
                      )));
        },
        child: Container(
          width: 100,
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xF1C40F),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                  Color(0xF1C40F)
                      .withOpacity(1), //Colors.black.withOpacity(.8),
                  Color(0xF1C40F)
                      .withOpacity(1), //Colors.black.withOpacity(.2),
                ])),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    title,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: -10,
                        blurRadius: 0,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: Colors.transparent,
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 5.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 5.0,
                            offset: Offset(0, 3))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage("$_profileImg"),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    messageContent,
                                    style: TextStyle(fontSize: 16),
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 8,
                                  backgroundImage: NetworkImage("$_profileImg"),
                                ),
                                SizedBox(width: 7),
                                Container(
                                  height: 18,
                                  width: 18,
                                  // padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: CustomTheme.colorAccent,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Text(name.substring(0, 1),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, //white
                                          fontSize: 15,
                                          fontFamily: 'OverpassRegular',
                                          fontWeight: FontWeight.w600)),
                                ),
                                SizedBox(width: 75),
                                Container(
                                  height: 20.0,
                                  width: 80,
                                  color: Colors.transparent,
                                  child: new Container(
                                      decoration: new BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: new BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(10.0),
                                            topRight:
                                                const Radius.circular(10.0),
                                            bottomLeft:
                                                const Radius.circular(10.0),
                                            bottomRight:
                                                const Radius.circular(10.0),
                                          )),
                                      child: new Center(
                                        child: new Text(time),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ), // this is responsible for the inside
        ),
      ), // overall container
    );
  }

  // This Widget creates the Blue Question tiles
  Widget questions({String questionContent, int timestamp, int likes, int comments}) {
    // Makes rectangles belongs in the questions section
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xF1C40F),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
                Color(0x5EC4F2).withOpacity(1), //Colors.black.withOpacity(.8),
                Color(0x5EC4F2).withOpacity(1), //Colors.black.withOpacity(.2),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage("$_profileImg"),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "  $_name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22.0,
                                          color: Colors.white),
                                    ),
                                  ]),
                                  overflow: TextOverflow.ellipsis,
                                )),
                                flex: 5,
                              ),

                            ],
                          ),
                        ),
                        Text(
                          "    Asked at " + readQuestionTimestamp(timestamp) + "                           ",
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "$questionContent",
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 22.5,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                // the comments and likes
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey),
                      children: [
                        //TextSpan(text: 'Created with '),
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: ' $likes',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  ),
                  SizedBox(width: 17.5),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.grey),
                      children: [
                        //TextSpan(text: 'Created with '),
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Icon(
                              Icons.chat,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: '  $comments',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        // this is responsible for the inside
      ), // overall container
    );
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }
}
