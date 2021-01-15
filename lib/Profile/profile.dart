/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Profile Page
  Description: Responsible for the UI and functions of Profile Page


 */


import 'package:buddyappfirebase/FirebaseData/FirebaseReference.dart';
import 'package:buddyappfirebase/GlobalWidget/CustomBottomNavigationBar.dart';
import 'package:buddyappfirebase/GlobalWidget/TimeStamp.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/GlobalWidget/progress.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:buddyappfirebase/Profile/ShowComment.dart';
import 'package:buddyappfirebase/Profile/editProfile.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Message/services/database.dart';

class ProfileView extends StatelessWidget {
  // bool isSelected;

  AppBar profileAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: Colors.grey),
      elevation: 0.0,
      title: Text(
        "Profile",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  //Responsible for the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: profileAppbar(),
            drawer: CustomDrawers(),
            body: ProfilePage(),
            bottomNavigationBar: CustomBottomNavigationBar()));
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final usersRef = Firestore.instance.collection('users');

class _ProfilePageState extends State<ProfilePage> {
  String _name = "";
  String name = EditProfile.profileName;
  String _profileImg = "";
  Stream chatRooms;
  List<dynamic> users;
  String className;
  String code;
  Map values = {};
  int amountOfClasses = 0;
  List questionValues = [];
  int amountOfQuestions = 0;
  QuerySnapshot searchResultSnapshot;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  var questions;
  TextEditingController searchEditingController = new TextEditingController();
  bool isLoading = false;
  bool userHaveQuestion = false;
  bool userHaveClass = false;
  bool userHaveComments = false;

  @override
  void initState() {
    super.initState();
    _getUserName();
    _getUserProfileImg();
    _getClasses();
    _searchQuestions();
  }

  // gets the profile img
  _getUserProfileImg() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
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

  _getClasses() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
    setState(() {
      values = doc.data["classes"];
      amountOfClasses = values.length;
    });

    print(values);
  }

  // search questions by name
  _searchQuestions() async {
    await databaseMethods.searchMyQuestions(Constants.myName).then((snapshot) {
      searchResultSnapshot = snapshot;
      print("$searchResultSnapshot");
      setState(() {
        isLoading = false;
        userHaveQuestion = true;
      });
    });
  }


  ListView profile(double height) {
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
                        'Classes',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Questions',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Answers',
                        textAlign: TextAlign.center,
                      ),
                    )
                  ]),
              Container(
                  height: 280,
                  child: TabBarView(
                    children: [
                      Center(
                        // Creates a ListView.builder
                        // *important - this list view builder uses MAP Data
                        child: classList(),
                      ),
                      Center(
                        child: questionList(),
                      ),
                      Center(
                        child: commentsList(),
                      )
                    ],
                  ))
            ],
          ))
    ]);
  }

  Widget classList() {
    return values != null
        ? ListView.builder(
            itemCount: values.length,
            itemBuilder: (context, index) {
              String key = values.keys.elementAt(index);
              return Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text("$key"),
                    subtitle: new Text("Code: ${values[key]}"),
                  ),
                  new Divider(
                    height: 2.0,
                  ),
                ],
              );
            })
        : Container();
  }

  // Widget creating list of questions
  Widget questionList() {
    return userHaveQuestion
        ? ListView.builder(
            // shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      searchResultSnapshot
                          .documents[index].data["questionContent"],
                    ),
                    subtitle: Text(
                      "Asked " +
                          TimeStamp().readQuestionTimeStamp(searchResultSnapshot
                              .documents[index].data["timeStamp"]),
                    ),
                  ),
                  Divider(
                    height: 2.0,
                  )
                ],
              );
            })
        : Container();
  }

  // Widget creating list of comments
  Widget commentsList() {
    return userHaveQuestion
        ? ListView.builder(
            // shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  GestureDetector(
                    child: ListTile(
                      title: Text(
                        searchResultSnapshot
                            .documents[index].data["questionContent"],
                      ),
                      subtitle: Text(
                        "View replies",
                        style: TextStyle(
                          color: Colors.blue[300],
                        ),
                      ),
                    ),
                    onTap: () {
                      // Todo left off here
                      if (searchResultSnapshot != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowComment(questionId: searchResultSnapshot.documents[index].data["questionId"],)),
                        );
                      }
                    },
                  ),
                  Divider(
                    height: 2.0,
                  )
                ],
              );
            })
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(body: profile(height));
  }
}
