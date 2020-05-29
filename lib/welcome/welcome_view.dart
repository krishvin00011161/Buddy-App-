import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:buddyappfirebase/welcome/helpers/ColorsSys.dart';
import 'package:buddyappfirebase/welcome/helpers/Strings.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key key}) : super(key: key);

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final NavigationService _navigationService = locator<NavigationService>();
  PageController _pageController;
  int currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: GestureDetector(
              onTap: () {
                _navigationService.navigateTo(HomeViewRoute);
              },
                child: Text('Skip', style: TextStyle(
                color: ColorSys.gray,
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),),
            ),
          )
        ],
      ),
      body: Stack(
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
                content: Strings.stepOneContent
              ),
              makeSetUpPage(
                image: 'assets/images/setup.jpg',
                title: Strings.stepTwoTitle,
                content: Strings.stepTwoContent
              ),
              makePage(
                image: 'assets/images/explore.jpg',
                title: Strings.stepThreeTitle,
                content: Strings.stepThreeContent
              ),
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
      ),
    );
  }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse ? 
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
              SizedBox(height: 30,),
            ],
          ) : SizedBox(),
          Text(title, style: TextStyle(
            color: ColorSys.primary,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20,),
          Text(content, textAlign: TextAlign.center, style: TextStyle(
            color: ColorSys.gray,
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),),
          reverse ? 
          Column(
            children: <Widget>[
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          ) : SizedBox(),
        ],
      ),
    );
  }

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
              SizedBox(height: 30,),
            ],
          ),
          Text(title, style: TextStyle(
            color: ColorSys.primary,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 20,),
          Text(content, textAlign: TextAlign.center, style: TextStyle(
            color: ColorSys.gray,
            fontSize: 20,
            fontWeight: FontWeight.w400
          ),),
        Container( // 2nd page
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Divider(
              height: 50.0,
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
              child: ButtonTheme( // Teacher Button
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
                      isTeacherPressed = true;
                      isStudentPressed = false;
                      // // Todo
                      // _navigationService.navigateTo(setUpViewRoute);
                    });
                    print(isTeacherPressed);
                  },
                 color: isTeacherPressed ? Colors.red : Colors.white,
                ),
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
                color: isStudentPressed ? Colors.blue : Colors.white,
                onPressed: () {
                  setState(() {
                    isTeacherPressed = false;
                    isStudentPressed = true;
                    
                  });
                  _navigationService.navigateTo(SetUpViewRoute);
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

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: ColorSys.secoundry,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }

}