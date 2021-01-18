/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Explore
  Description: UI and Functionality of Explore


 */

import 'package:buddyappfirebase/Explore/Screens/RecommendedQuestionsView.dart';
import 'package:buddyappfirebase/Explore/Widget/SearchExploreCard.dart';
import 'package:buddyappfirebase/FirebaseData/FirebaseReference.dart';
import 'package:buddyappfirebase/GlobalWidget/TextEditingControllers.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:buddyappfirebase/GlobalWidget/progress.dart';
import 'package:buddyappfirebase/Home/Widgets/CustomDrawers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../FirebaseData/firebaseMethods.dart';
import '../../Message/services/database.dart';
import '../../home/screens/composeScreen.dart';
import 'SearchQuestion.dart';
import 'classesQuestionView.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:buddyappfirebase/GlobalWidget/CustomBottomNavigationBar.dart';
import 'dart:ui' as ui;

class ExplorePage extends StatefulWidget {
  final int index;
  ExplorePage({this.index});
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _profileImg = "";
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot searchResultSnapshot;
  Stream<QuerySnapshot> recommends;
  Stream<QuerySnapshot> classes;
  bool isLoading = false;
  bool haveUserSearched = false;
  Map values = {};
  int amountOfClasses = 0;

  @override
  void initState() {
    super.initState();
    _getUserProfileImg();
    _getAmountOfRecommends();
    _getAmountOfClasses();
  }

  // searches for question with keyword
  _searchQuestion() async {
    if (TextEditingControllers.searchEditingControllers.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await databaseMethods
          .searchMyQuestions(TextEditingControllers.searchEditingControllers
              .text) // find a better name here for textediting
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

  _getAmountOfRecommends() async {
    databaseMethods.getRecommend("categories").then((val) {
      setState(() {
        recommends = val;
      });
    });
  }

  _getAmountOfClasses() async {
    databaseMethods.getClasses("classes").then((val) {
      setState(() {
        classes = val;
      });
    });
  }





  var items = [
    PlaceInfo('Dubai Mall Food Court', Color(0xff6DC8F3), Color(0xff73A1F9),
        4.4, 'Dubai · In The Dubai Mall', 'Cosy · Casual · Good for kids'),
    PlaceInfo('Hamriyah Food Court', Color(0xffFFB157), Color(0xffFFA057), 3.7,
        'Sharjah', 'All you can eat · Casual · Groups'),
    PlaceInfo('Gate of Food Court', Color(0xffFF5B95), Color(0xffF8556D), 4.5,
        'Dubai · Near Dubai Aquarium', 'Casual · Groups'),
    PlaceInfo('Express Food Court', Color(0xffD76EF5), Color(0xff8F7AFE), 4.1,
        'Dubai', 'Casual · Good for kids · Delivery'),
    PlaceInfo('BurJuman Food Court', Color(0xff42E695), Color(0xff3BB2B8), 4.2,
        'Dubai · In BurJuman', '...'),
  ];

  Widget recommendList() {
    return StreamBuilder(
        stream: recommends,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RecommendedQuestionView(
                                              categories: snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['categories'])),
                                );
                              },
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(
                                      colors: [
                                        items[index].startColor,
                                        items[index].endColor
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  boxShadow: [
                                    BoxShadow(
                                      color: items[index].endColor,
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: CustomPaint(
                                size: Size(100, 150),
                                painter: CustomCardShapePainter(
                                    24,
                                    items[index].startColor,
                                    items[index].endColor),
                              ),
                            ),
                            Positioned.fill(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      'assets/icon.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.documents[index]
                                              .data['categories'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          "",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          items[index]
                                              .rating
                                              .toString(), // keep for later
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Avenir',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        // RatingBar(rating: items[index].rating),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container(color: Colors.blue);
        });
  }

  Widget classList() {
    return StreamBuilder(
        stream: classes,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ClassQuestionView(
                                             className: snapshot.data.documents[index].data['className'],)),
                                );
                              },
                              child: Container(
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  gradient: LinearGradient(
                                      colors: [
                                        items[index].startColor,
                                        items[index].endColor
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  boxShadow: [
                                    BoxShadow(
                                      color: items[index].endColor,
                                      blurRadius: 12,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: CustomPaint(
                                size: Size(100, 150),
                                painter: CustomCardShapePainter(
                                    24,
                                    items[index].startColor,
                                    items[index].endColor),
                              ),
                            ),
                            Positioned.fill(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Image.asset(
                                      'assets/icon.png',
                                      height: 64,
                                      width: 64,
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.documents[index]
                                              .data['className'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          snapshot.data.documents[index]
                                              .data['classCode'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Avenir',
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          items[index]
                                              .rating
                                              .toString(), // keep for later
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Avenir',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        // RatingBar(rating: items[index].rating),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
              : Container(color: Colors.blue);
        });
  }

  // responsible for UI
  SingleChildScrollView exploreBody() {
    return SingleChildScrollView(
      child: Column(
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey, width: 3)),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    hintText: "Search question",
                    suffixIcon: Icon(Icons.search)),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchQuestion()));
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
          Container(
            height: 370,
            width: 390,
            child: classList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
          Container(
            height: 370,
            width: 390,
            child: recommendList(),
          ),
        ],
      ),
    );
  }

  // responsible for AppBar UI
  AppBar exploreAppBar() {
    // App bar
    return AppBar(
      iconTheme: new IconThemeData(color: Colors.grey),
      backgroundColor: Colors.grey[100],
      elevation: 0,
      leading: IconButton(
        icon: CircleAvatar(
          backgroundImage: NetworkImage("$_profileImg"),
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text(
        "Explore",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  // responsible for the whole Explore view
  Scaffold exploreView() {
    return Scaffold(
      key: _scaffoldKey,
      appBar: exploreAppBar(),
      drawer: CustomDrawers(),
      body: exploreBody(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return exploreView();
  }
}

class PlaceInfo {
  final String name;
  final String category;
  final String location;
  final double rating;
  final Color startColor;
  final Color endColor;

  PlaceInfo(this.name, this.startColor, this.endColor, this.rating,
      this.location, this.category);
}

class CustomCardShapePainter extends CustomPainter {
  final double radius;
  final Color startColor;
  final Color endColor;

  CustomCardShapePainter(this.radius, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - radius, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - radius)
      ..lineTo(size.width, radius)
      ..quadraticBezierTo(size.width, 0, size.width - radius, 0)
      ..lineTo(size.width - 1.5 * radius, 0)
      ..quadraticBezierTo(-radius, 2 * radius, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
