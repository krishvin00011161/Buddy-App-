import 'package:buddyappfirebase/login/constants/route_names.dart';
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
  final NavigationService _navigationService = locator<NavigationService>();

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
    bool teacherPressed = false;
    bool studentPressed = false;
    List<Widget> pages = [
      Container( // first page
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
      Container( // 2nd page
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        
            Image(
              image: AssetImage("assets/images/setup.jpg"),
              width: 300,
            ),
            Text(
              "Setup and customization",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            verticalSpaceSmall,
            Text(
              "Set up your experience to meet your \n requirements your experiences",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            Divider(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: [
            ButtonTheme( // Teacher Button
                minWidth: 130.0,
                height: 50.0,
                child: RaisedButton(
                child: Text("Teacher"),
                shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.blueAccent)
                  
                ),
                
                onPressed: () {
                  setState(() {
                    teacherPressed = true;
                    studentPressed = false;
                    // Todo
                    _navigationService.navigateTo(setUpViewRoute);
                  });
                },
                color: teacherPressed ? Colors.blue : Colors.white,
              ),
            ),
            ButtonTheme( // Student Button
                minWidth: 130.0,
                height: 50.0,
                child: RaisedButton(
                child: Text("Student"),
                shape: RoundedRectangleBorder(
                  borderRadius:  BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.blueAccent), 
                ),
                color: studentPressed ? Colors.blue : Colors.white,
                onPressed: () {
                  setState(() {
                    teacherPressed = false;
                    studentPressed = true;
                  });
                },
              ),
            ),
              ],
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
    if (teacherPressed) {
      pages = [
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
              "Teacher setup",
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