import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/helper/theme.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
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
import '../../Explore/screen/explore.dart';

// This class is responsible for the home page
class MainHomeView extends StatefulWidget {
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
  Stream<QuerySnapshot> chats;
  String message;

  @override
  void initState() {
    super.initState();
    _getUserProfileImg();
    _getUserName();
    _getUserQuestion();
    getUserInfogetChats();
    DatabaseMethods().getChats("Aaron_David").then((val) {
      setState(() {
        chats = val;
      });
    });
    chatMessages();
    print(message);
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

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  message = snapshot.data.documents[index].data["messages"][snapshot.data.documents.length-1];
                  // return MessageTile(
                  //   message: snapshot.data.documents[index].data["message"],
                  //   sendByMe: Constants.myName ==
                  //       snapshot.data.documents[index].data["sendBy"],
                  //     lastChat: Chat.lastChat = snapshot.data.documents[index].data["message"],
                  // );
                })
            : Container();
      },
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
                      "Groups 3",
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
                  ),
                ]),
                SizedBox(
                  height: 20,
                ),
                FadeAnimation(
                  1.4,
                  Container(
                    height: 280,
                    child: StreamBuilder(
                        stream: chatRooms,
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.documents.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return groups(
                                        title: snapshot.data.documents[index]
                                            .data['chatRoomId']
                                            .toString()
                                            .replaceAll("_", "")
                                            .replaceAll(Constants.myName, ""),
                                        messageContent: "Hi",
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
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      itemCount: questionValues.length,
                      itemBuilder: (context, int index) {
                        // Logic
                        // If 1 == 2 false, 2 == 2 true then create question widget then question add button
                        print(questionValues.length);
                        print(index);
                        if (questionValues.length >= 1) {
                          return Row(
                            children: <Widget>[
                              questions(questionContent: questionValues[index]),
                            ],
                          );
                        }
                      },
                    ),
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
      String name}) {
    // Makes Rectangles belongs in the groups section
    return AspectRatio(
      aspectRatio: 10 / 9.3,
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
                Color(0xF1C40F).withOpacity(1), //Colors.black.withOpacity(.8),
                Color(0xF1C40F).withOpacity(1), //Colors.black.withOpacity(.2),
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
                                          topLeft: const Radius.circular(10.0),
                                          topRight: const Radius.circular(10.0),
                                          bottomLeft:
                                              const Radius.circular(10.0),
                                          bottomRight:
                                              const Radius.circular(10.0),
                                        )),
                                    child: new Center(
                                      child: new Text("11:26 pm"),
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
      ), // overall container
    );
  }

  // This Widget creates the Blue Question tiles
  Widget questions({String questionContent}) {
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
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                    child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: "$_name",
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
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 13,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.add),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ComposeScreen()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            "Asked at 25, September 2020",
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                            maxLines: 1,
                          ),
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
                            child: Icon(Icons.thumb_up),
                          ),
                        ),
                        TextSpan(
                            text: ' 8',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
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
                            child: Icon(Icons.chat),
                          ),
                        ),
                        TextSpan(
                            text: '  2',
                            style:
                                TextStyle(color: Colors.black, fontSize: 20)),
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
