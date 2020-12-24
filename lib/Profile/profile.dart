import 'package:buddyappfirebase/Explore/screen/explore.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseMethods.dart';
import 'package:buddyappfirebase/Global%20Widget/progress.dart';
import 'package:buddyappfirebase/Message/helper/constants.dart';
import 'package:buddyappfirebase/Message/helper/helperfunctions.dart';
import 'package:buddyappfirebase/Profile/editProfile.dart';
import 'package:buddyappfirebase/Message/services/database.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:buddyappfirebase/FirebaseData/firebaseReferences.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../Message/services/database.dart';

class ProfileView extends StatelessWidget {
  int _currentIndex = 0;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
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

  @override
  void initState() {
    super.initState();
    _getUserName();
    _getUserProfileImg();
    _getClasses();
    _getUserQuestion();
    _getUserQ("David");
    initiateSearch();
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

  // gets classes
  _getClasses() async {
    FirebaseMethods().getUserClasses();
    setState(() {
      values = FirebaseMethods.classValues;
      amountOfClasses = amountOfClasses;
    });
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

    print(values);
  }

  var questions;

  _getUserQ(String userName) async {
    DatabaseMethods().getLatestQuestions('userName').then((QuerySnapshot doc) {
      if (doc.documents.isNotEmpty) {
        questions = doc.documents[0].data;
        print(questions);
      }
    });
  }

  TextEditingController searchEditingController = new TextEditingController();

  bool isLoading = false;
  bool haveUserSearched = false;

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
            // shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  ListTile(
                      title: Text(
                          searchResultSnapshot
                              .documents[index].data["questionContent"],
                          style: TextStyle(color: Colors.black, fontSize: 16))),
                  Divider(
                    height: 2.0,
                  )
                ],
              );
              // return userTile(
              //   searchResultSnapshot.documents[index].data["questionContent"],
              // );
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
            children: <Widget>[
              // ListTile(
              //   title: Text(content, style: TextStyle(color: Colors.black, fontSize: 16))
              // ),
              // Divider(
              //   height: 2.0,
              // ),
              Text(
                content,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Divider(
                height: 2.0,
                color: Colors.black,
              )
            ],
          ),
        ],
      ),
    );
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
                        child: ListView.builder(
                            shrinkWrap: false,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                        "U.S History"),
                                    subtitle: Text(
                                        "Code: GHE134"),
                                  ),
                                  Divider(height: 2.0),
                                  ListTile(
                                    title: Text(
                                        "Chemistry I"),
                                    subtitle: Text(
                                        "Code: DER321"),
                                  ),
                                  Divider(height: 2.0),
                                  ListTile(
                                    title: Text(
                                        "Psychology"),
                                    subtitle: Text(
                                        "Code: DLE983"),
                                  ),
                                  Divider(height: 2.0),
                                  ListTile(
                                    title: Text(
                                        "Literature"),
                                    subtitle: Text(
                                        "Code: DEW342"),
                                  ),
                                  
                                ],
                              );
                            }),
                      ),
                      Center(
                        child: userList(),
                      ),
                      Center(
                        child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text(
                                        "Greek word for indivisible"),
                                    subtitle: Text(
                                        "Question: What is an Atom?"),
                                  ),
                                  Divider(height: 2.0),
                                  ListTile(
                                    title: Text(
                                        "Robert Oppenheimer"),
                                    subtitle: Text(
                                        "Question: Who made the atomic bomb?"),
                                  ),
                                  Divider(height: 2.0),
                                  ListTile(
                                    title: Text(
                                        "The 16th president of the United States."),
                                    subtitle: Text(
                                        "Question: Who is Lincoln?"),
                                  ),
                                  
                                ],
                              );
                            }),
                      )
                    ],
                  ))
            ],
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(body: Profile(height));
  }
}
