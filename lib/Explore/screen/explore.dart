import 'package:buddyappfirebase/Explore/Widget/search_explore_card.dart';
import 'package:buddyappfirebase/Explore/screen/classesQuestionView.dart';
import 'package:buddyappfirebase/Explore/screen/recommendedQuestionsview.dart';
import 'package:buddyappfirebase/Explore/screen/searchQuestion.dart';
import 'package:buddyappfirebase/Global%20Widget/progress.dart';
import 'package:buddyappfirebase/Message/views/chatrooms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../FirebaseData/firebaseMethods.dart';
import '../../Message/helper/constants.dart';
import '../../Message/helper/helperfunctions.dart';
import '../../FirebaseData/firebaseReferences.dart';
import '../../Message/services/database.dart';
import '../../home/screens/MainHomeView.dart';
import '../../home/screens/composeScreen.dart';
import '../../home/widgets/custom_drawers.dart';
import 'classesQuestionView.dart';

class ExplorePage extends StatefulWidget {
  final int index;
  ExplorePage({this.index});
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _profileImg = "";
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;
  bool isLoading = false;
  bool haveUserSearched = false;
  Map values = {};
  int amountOfClasses = 0;

  initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchMyQuestions(searchEditingController.text)
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

  Widget userList() {
    return haveUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.documents.length,
            itemBuilder: (context, index) {
              return userTile(
                  searchResultSnapshot.documents[index].data["questionContent"],
                  searchResultSnapshot
                      .documents[index].data["questionContent"]);
            })
        : Container();
  }

  CupertinoTabBar tabBar() {
    return CupertinoTabBar(
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
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserProfileImg();
    _getClasses();
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

  // gets classes
  _getClasses() async {
    FirebaseMethods().getUserClasses();
    setState(() {
      values = FirebaseMethods.classValues;
      amountOfClasses = FirebaseMethods.amountOfClasses;
    });
  }

  SingleChildScrollView exploreBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(11.5),
            child: Container(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8.0),
                    border: new OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide:
                            new BorderSide(color: Colors.grey, width: 3)),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    hintText: "Search question",
                    suffixIcon: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchQuestion()));
                        },
                        child: Icon(Icons.search))),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(11.5),
                child: Text(
                  "Good Morning",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExploreCard(
                      imgScr: 'assets/images/history.jpg',
                      title: "U.S History",
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassQuestionView(
                                className: "U.S History",
                              )),
                    );
                  }),
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExploreCard(
                      imgScr: 'assets/images/chemistry.jpg',
                      title: "Chemistry I",
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassQuestionView(
                                className: "Chemistry",
                              )),
                    );
                  }),
            ],
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExploreCard(
                      imgScr: 'assets/images/psychology.jpg',
                      title: "Psychology",
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassQuestionView(
                                className: "Psychology",
                              )),
                    );
                  }),
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExploreCard(
                      imgScr: 'assets/images/literature.jpg',
                      title: "Literature",
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClassQuestionView(
                                className: "Literature",
                              )),
                    );
                  }),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(11.5),
                    child: Text(
                      "Recommended",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExploreCard(
                          imgScr: 'assets/images/history1.jpg',
                          title: "History",
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecommendedQuestionView(
                                    categories: "History",
                                  )),
                        );
                      }),
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExploreCard(
                          imgScr: 'assets/images/chemistry1.jpg',
                          title: "Chemistry",
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecommendedQuestionView(
                                    categories: "Chemistry",
                                  )),
                        );
                      }),
                ],
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExploreCard(
                          imgScr: 'assets/images/english.jpg',
                          title: "English",
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecommendedQuestionView(
                                    categories: "English",
                                  )),
                        );
                      }),
                  GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExploreCard(
                          imgScr: 'assets/images/psychology1.jpg',
                          title: "Psychology",
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecommendedQuestionView(
                                    categories: "Psychology",
                                  )),
                        );
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar exploreAppBar() {
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
      title: Text(
        "Explore",
        style: TextStyle(color: Colors.black),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ComposeScreen()));
          },
        )
      ],
    );
  }

  Scaffold exploreView() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: exploreAppBar(),
      drawer: CustomDrawers(),
      body: exploreBody(),
      bottomNavigationBar: tabBar(),
    );
  }

  Widget classes({String nameOfCourse}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: ExploreCard(
          imgScr: 'assets/images/coding.jpg',
          title: nameOfCourse,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassQuestionView(
                      className: nameOfCourse,
                    )),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return exploreView();
  }
}

Widget userTile(String userName, String userEmail) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              userEmail,
              style: TextStyle(color: Colors.black, fontSize: 16),
            )
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(24)),
            child: Text(
              "Message",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        )
      ],
    ),
  );
}
