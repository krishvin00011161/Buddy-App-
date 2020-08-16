import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:buddyappfirebase/Explore/explore.dart';
import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Profile/editProfile.dart';
import 'package:buddyappfirebase/emailuser.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/home/homeUser.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProfileView extends StatelessWidget {
  int _currentIndex = 0;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
            appBar: ProfileAppbar(),
            drawer: CustomDrawers(),
            body: ProfilePage(),
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
            )));
  }

  AppBar ProfileAppbar() {
    bool isSearching = false;

    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        "Profile",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}
final usersRef = Firestore.instance.collection('users');
class _ProfilePageState extends State<ProfilePage> {
  String _name = "";
  int _classCount = 0;
  String _questionCount = "1";
  String _answerCount = "999999";
  String _profileImg = "";
  Stream chatRooms;
  String _className;
  List<dynamic> users;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName();
    getUserProfileImg();
    getUserClass();
  }

  // gets user name
  getUserName() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats(Constants.myName).then((snapshots) {
      setState(() {
        _name = Constants.myName;     
      });
    });
  }

  // gets user profile
  getUserProfileImg() async {
    final String id = "AqT9eOHoHicNswTAoCYP";
    final DocumentSnapshot doc = await usersRef.document(id).get();
     setState(() {
       _profileImg = doc.data["photoUrl"];
     });

    print(doc.documentID);
    return _profileImg;

     // may help
  }


  // gets user class
  getUserClass() async {
    final String id = "AqT9eOHoHicNswTAoCYP";
    final DocumentSnapshot doc = await usersRef.document(id).get();
    setState(() {
      _classCount = 1;
      _className = doc.data["classes"];
    });
  }


  
  ListView Profile(double height) {
    return ListView(children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "$_name",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      Container(
          height: 120,
          child: Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "$_profileImg",
              ),
            ),
          )),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            color: Colors.transparent,
            onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
            child: Text(
              'EDIT PROFILE',
              style: TextStyle(
                fontSize: 17,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
      Divider(),
      DefaultTabController(
          length: 3,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.blueAccent,
                  tabs: [
                    Tab(
                      child: Text(
                        '$_classCount\nClasses',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        '$_questionCount\nQuestions',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        '$_answerCount\nAnswers',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
              Container(
                  height: 250,
                  child: TabBarView(
                    children: [
                      Center(child: 
                            ListTile(
                              title: Text("$_className"),
                            ),    
                      ),
                      Center(child: Text('Not Made Yet')),
                      Center(child: Text('Not Made yet')),
                    ],
                  ))
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Profile(height)
      );
  }
}
