import 'package:buddyappfirebase/Explore/screen/composeScreen.dart';
import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/Widget/firebaseReferences.dart';
import 'package:buddyappfirebase/Widget/progress.dart';
import 'package:buddyappfirebase/home/animation/FadeAnimation.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Explore/explore.dart';

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

  @override
  void initState() {
    super.initState();
    getUser();
    _getUserProfileImg();
    _getUserName();
    _getUserQuestion();
  }

  // This is a debugging call, tells what user is auto logined
  getUser() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        chatRooms = snapshots;
        print("this is name  ${Constants.myName}");
      });
    });
  }

  // This gets the profile Img url
  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["photoUrl"] != null)
        ? setState(() {
            _profileImg = doc.data["photoUrl"];
          })
        : circularProgress();
  }

  // gets user name
  _getUserName() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();

    (doc.data["userName"] != null)
        ? setState(() {
            _name = doc.data["userName"];
          })
        : circularProgress();
  }

  // gets question
  _getUserQuestion() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot docQuestion =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
    setState(() {
      questionValues = docQuestion.data["questions"];
      amountOfQuestions = questionValues.length;
    });

    //print(values);
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
              hintText: "Ask a question",
              suffixIcon: Icon(Icons.search)),
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
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          groups(title: 'U.S. History'),
                          groups(title: 'Chemistry'),
                          groups(title: 'Greece'),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                    ),
                    Container(
                      height: 4,
                      width: 35,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 4,
                      width: 35,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 4,
                      width: 35,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
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
                      reverse: false,
                      itemCount: questionValues.length,
                      itemBuilder: (context, int index) {
                        // Logic
                        // If 1 == 2 false, 2 == 2 true then create question widget then question add button
                        if (index+1 == questionValues.length) {
                          return Row(
                            children: <Widget>[
                              questions(questionContent: questionValues[index]),
                              questionsAddButton(),
                            ],
                          );
                        }

                        return new Row(
                          children: <Widget>[
                            questions(questionContent: questionValues[index]),
                            
                          ],
                        );
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
  Widget groups({title}) {
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
                height: 170.0,
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
                                  "Yo, Send me the Answers to the HW",
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
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                    "https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 7),
                              CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.blue,
                              ),
                              SizedBox(width: 30),
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

  // This widget creates a empty Blue Question tile with a plus logo
  Widget questionsAddButton({title}) {
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
              SizedBox(
                height: 35,
              ),
              // Todo:
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ComposeScreen()),
                    );
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
