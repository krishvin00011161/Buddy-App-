import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            PageView(
              //physics:new NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                pageNum = index;
                pageIndicators();
              },
              children: pages(),
//              <Widget>[
//                Container(
//                  color: Colors.red,
//                ),
//
//                for(int i = 0; i < 4; i++){
//
//                },
//              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      onPressed: () {
                        backPage();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                    Row(
                      children: pageIndicators(),
                    ),
                    FlatButton(
                      child: Text(
                        "$_next",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        nextPage();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                  ],
                ),
                verticalSpaceLarge,
              ],
            ),
          ],
        ),
      ),
    );
  }

  int pageNum = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void backPage() {
    setState(() {
      pageController.animateToPage(pageNum - 1,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void nextPage() {
    setState(() {
      if (pageNum == 2) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeView(),
          ),
        );
      } else {
        pageController.animateToPage(pageNum + 1,
            duration: Duration(milliseconds: 500), curve: Curves.ease);
      }
    });
  }

  List<Widget> pages() {
    bool isTeacher = false;
    List<Widget> pages = [
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/connect.jpg"),
              width: 300,
            ),
            Text(
              "Connect with friends",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            verticalSpaceSmall,
            Text(
              "Lets connect to discuss your study\nPlans and your meetings",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage("assets/images/explore.jpg"),
              width: 300,
            ),
            Text(
              "Explore",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            verticalSpaceSmall,
            Text(
              "Explore and Connect whatever\nyour heart desires",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    ];
    if (isTeacher) {
      pages = [
        Container(
          child: Stack(
            children: <Widget>[
              RaisedButton(
                child: Text("add page"),
                onPressed: () {
                  print("lol");
                },
              ),
            ],
          ),
          color: Colors.green,
        ),
      ];
    } else {
      pages.addAll([
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/setup.jpg"),
                width: 300,
              )
            ],
          ),
        ),
      ]);
    }
    return pages;
  }

  String _next = "Next";

  List<Widget> pageIndicators() {
    List<Widget> indicators = [
      Container(
        width: 10.0,
        height: 10.0,
        decoration: new BoxDecoration(
          color: pageNum == 0 ? Colors.blue : Colors.grey,
          shape: BoxShape.circle,
        ),
      ),

      Container(
        width: 10.0,
        height: 10.0,
        decoration: new BoxDecoration(
          color: pageNum == 1 ? Colors.blue : Colors.grey,
          shape: BoxShape.circle,
        ),
      ),

      Container(
        width: 10.0,
        height: 10.0,
        decoration: new BoxDecoration(
          color: pageNum == 2 ? Colors.blue : Colors.grey,
          shape: BoxShape.circle,
        ),
      ),

//      Container(
//        width: 10.0,
//        height: 10.0,
//        decoration: new BoxDecoration(
//          color: pageNum == 3 ? Colors.blue : Colors.grey,
//          shape: BoxShape.circle,
//        ),
//      ),
    ];
    if (pageNum == 2) {
      _next = "Finish";
    } else {
      _next = "Next";
    }
    setState(() {});
    return indicators;
  }
}
