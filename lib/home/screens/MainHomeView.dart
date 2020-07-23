import 'package:buddyappfirebase/Message/helper/authenticate.dart';
import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/home/animation/FadeAnimation.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Explore/explore.dart';

//Dk

class MainHomeView extends StatefulWidget {
  @override
  _MainHomeViewState createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Stream chatRooms;

  logout() {
    googleSignIn.signOut();
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Authenticate()),
  );
  }

  @override
  void initState() {
    getUserInfogetChats();
    super.initState();
  }

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


  Scaffold home() { // This is responsible for the Home View
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
    return CupertinoTabBar( // Code reuse make some class Reminder
          
          currentIndex: _currentIndex,
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
            builder: (context) => ChatRoom()),
          );
      }
      },
    );
  }

  AppBar homeAppBar() { // App bar
    return AppBar(
        iconTheme: new IconThemeData(color: Colors.grey),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: new IconButton(
          icon: CircleAvatar(backgroundImage: NetworkImage("https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: Container(
          width: 310,
          child: TextField(
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.all(8.0),
              border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: new BorderSide(color: Colors.grey, width: 3)),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
              hintText: "Ask a question", 
              suffixIcon: Icon(Icons.search)
            ),
          ),
        ),
      );
  }

  SingleChildScrollView homeBody() { // Anything body related
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                    FadeAnimation(1, Text(
                    "Groups 3", 
                    style: TextStyle(
                      fontWeight: 
                      FontWeight.bold, 
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
                    ]
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(1.4, Container(
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
                  SizedBox(height: 30,),
                  Row(children: [
                    SizedBox(width: 60,),
                    Container(
                      height: 4,
                      width: 35,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 30,),
                    Container(
                      height: 4,
                      width: 35,
                      color: Colors.grey[300],
                    ),
                    SizedBox(width: 30,),
                    Container(
                      height: 4,
                      width: 35,
                      color: Colors.grey[300],
                    ),
                  ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: <Widget>[
                      FadeAnimation(1, Text("Questions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),)),
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
                  
                  SizedBox(height: 20,),                
                  FadeAnimation(1.4, Container(
                    height: 225,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        questions(title: 'Canada'),
                        questions(title: 'Italy'),
                        questions(title: 'Greece'),
                        questions(title: 'United States')
                      ],
                    ),
                  )),
                  SizedBox(height: 80,),
                ],
              ),
            )
          ],
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    
    return home();
  }
}


  Widget groups({title}) {  // Makes Rectangles belongs in the groups section
    return AspectRatio(
      aspectRatio: 10/9.3,
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
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Color(0xF1C40F).withOpacity(1), //Colors.black.withOpacity(.8),
                Color(0xF1C40F).withOpacity(1), //Colors.black.withOpacity(.2),
              ]
            )
          ),
          child: Column(
            children: [
              Align(
              alignment: Alignment.topLeft,
              child: Flexible(child: Text(title, style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)), textAlign: TextAlign.left,)),
              ),
              SizedBox(height: 10,),
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
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9.0),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300], blurRadius: 5.0, offset: Offset(0, 3))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage("https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
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
                  backgroundImage: NetworkImage(""),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 7),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(""),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 7),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(""),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 7),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(""),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 7),
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(""),
                  backgroundColor: Colors.blue,
                ),
                SizedBox(width: 7),
              ],
            ),
            SizedBox(height: 10,),
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
                bottomLeft: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0),
              )
            ),
            child: new Center(
            child: new Text("11:26 pm"),
           )
         ),
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

  Widget questions({title}) { // Makes rectangles belongs in the questions section 
    return AspectRatio(
      
      aspectRatio: 4 / 3,
      child:  Container(
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
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Color(0x5EC4F2).withOpacity(1), //Colors.black.withOpacity(.8),
                Color(0x5EC4F2).withOpacity(1), //Colors.black.withOpacity(.2),
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                  children: <Widget>[
                    CircleAvatar(
                    backgroundImage: NetworkImage("https://picturecorrect-wpengine.netdna-ssl.com/wp-content/uploads/2014/03/portrait-photography.jpg"),
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
                                  child: Container(child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text:"Sean Kernan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0, color: Colors.white),),
                                      ]
                                    ),overflow: TextOverflow.ellipsis,
                                  )),flex: 5,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text("Asked at 25, September 2020", style: TextStyle(fontSize: 14.0, color: Colors.white), maxLines: 1, ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              SizedBox(height: 10,),
              Align(
              alignment: Alignment.bottomLeft,
              child: Text("What is the most fact about people you know", style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white, fontSize: 22.5, fontWeight: FontWeight.bold)),),
              ),
              SizedBox(height: 25,),
              Row( // the comments and likes
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RichText(
                text: TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                //TextSpan(text: 'Created with '),
                WidgetSpan(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(
                  Icons.thumb_up),
              ),
            ),
            TextSpan(text: ' 8', style: TextStyle(color: Colors.black, fontSize: 20)),
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
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(Icons.chat),
              ),
            ),
            TextSpan(text: '  2', style: TextStyle(color: Colors.black, fontSize: 20)),
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

 