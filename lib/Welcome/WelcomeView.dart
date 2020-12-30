/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Welcome View UI
  Description: This class display images, screens, and text in welcome view


 */

import 'package:buddyappfirebase/welcome/SetUpClassStudent.dart';
import 'package:buddyappfirebase/welcome/SetUpClassTeachers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:buddyappfirebase/welcome/helpers/ColorsSys.dart';
import 'package:buddyappfirebase/welcome/helpers/Strings.dart';




class WelcomeView extends StatefulWidget {

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  PageController _pageController;
  int currentIndex = 0;


  // runs when the page appears
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  // Responsible UI of App Bar
  AppBar welcomeViewAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      actions: <Widget>[],
    );
  }
 
  // Responsible UI of Welcome View Body
  Stack welcomeViewBody() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        PageView(
          onPageChanged: (int page) {
            setState(() {
              currentIndex = page;
            });
          },
          controller: _pageController,
          children: <Widget>[
            makePage(
                image: 'assets/images/connect.jpg',
                title: Strings.stepOneTitle,
                content: Strings.stepOneContent),
            makePage(
                image: 'assets/images/explore.jpg',
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent),
            makeSetUpPage(
                image: 'assets/images/setup.jpg',
                title: Strings.stepTwoTitle,
                content: Strings.stepTwoContent),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildIndicator(),
          ),
        )
      ],
    );
  }

  // Widget that makes Pages
  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse
              ? Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : SizedBox(),
          Text(
            title,
            style: TextStyle(
                color: ColorSys.primary,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorSys.gray,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          reverse
              ? Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image),
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }

  // Widget that make the Set Up Page
  Widget makeSetUpPage({image, title, content}) {
    bool isTeacherPressed = false;
    bool isStudentPressed = false;
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
                color: ColorSys.primary,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: ColorSys.gray,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
          Container(
            // 2nd page
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Divider(
                  color: Colors.transparent,
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTeacherPressed = true;
                          isStudentPressed = false;
                        });
                      },
                      child: ButtonTheme(
                        // Teacher Button
                        minWidth: 130.0,
                        height: 50.0,
                        child: RaisedButton(
                          child: Text("Teacher"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.blueAccent)),
                          onPressed: () {
                            setState(() {
                              isTeacherPressed = true;
                              isStudentPressed = false;
                              // // Todo
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Setup(), // fix later
                                ),
                              );
                            });
                            print(isTeacherPressed);
                          },
                          color: isTeacherPressed ? Colors.red : Colors.white,
                        ),
                      ),
                    ),
                    ButtonTheme(
                      // Student Button
                      minWidth: 130.0,
                      height: 50.0,
                      child: RaisedButton(
                        child: Text("Student"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.blueAccent),
                        ),
                        color: isStudentPressed ? Colors.blue : Colors.white,
                        onPressed: () {
                          // sets user role
                          //_navigationService.navigateTo(SetUpStudent);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetUpStudent(), // fix later
                            ),
                          );
                          setState(() {
                            isTeacherPressed = false;
                            isStudentPressed = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // This Widget animates between screens
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(5)),
    );
  }

  // This Function indicate with view it is in
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: welcomeViewAppBar(),
      body: welcomeViewBody(),
    );
  }
}
