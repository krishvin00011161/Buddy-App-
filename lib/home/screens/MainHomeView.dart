import 'package:buddyappfirebase/home/animation/FadeAnimation.dart';
import 'package:buddyappfirebase/login/constants/route_names.dart';
import 'package:buddyappfirebase/login/services/navigation_service.dart';
import 'package:buddyappfirebase/login/locator.dart';
import 'package:buddyappfirebase/home/widgets/custom_app_bar.dart';
import 'package:buddyappfirebase/home/widgets/custom_drawers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainHomeView extends StatefulWidget {
  @override
  _MainHomeViewState createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final NavigationService _navigationService = locator<NavigationService>();





  logout() {
    googleSignIn.signOut();
    _navigationService.navigateTo(StartViewRoute);
  }

  Scaffold home() {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey),
        backgroundColor: Colors.grey[100],
        elevation: 0,
        //leading: Icon(Icons.menu, color: Colors.grey,),
        title: Container(
          width: 310,
          child: TextField(
            decoration: InputDecoration(
              contentPadding:  EdgeInsets.all(8.0),
              border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: new BorderSide(color: Colors.grey, width: 3)),
              //prefixIcon: Icon(Icons.search, color: Colors.grey,),
              //icon: Icon(Icons.search, color: Colors.grey,),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold),
              hintText: "Ask a question", 
              suffixIcon: Icon(Icons.search)
            ),
          ),
        ),
      ),
      drawer: CustomDrawers(),
      body: SingleChildScrollView(
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
                      child: Text("See all >"),
                    ),
                    ]
                  ),
                  SizedBox(height: 20,),
                  FadeAnimation(1.4, Container(
                    height: 280,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Groups(image: 'assets/images/0.jpg', title: 'U.S. History'),
                        Groups(image: 'assets/images/0.jpg', title: 'Chemistry'),
                        Groups(image: 'assets/images/2.jpg', title: 'Greece'),
                        Groups(image: 'assets/images/7.jpg', title: 'United States')
                      ],
                    ),
                  )),

                  SizedBox(height: 60,),
                  Row(
                    children: <Widget>[
                      FadeAnimation(1, Text("Questions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 35),)),
                      Spacer(),
                      GestureDetector(
                        child: Text("See all >"),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 20,),                
                  FadeAnimation(1.4, Container(
                    height: 225,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Questions(image: 'assets/images/5.jpg', title: 'Canada'),
                        Questions(image: 'assets/images/6.jpg', title: 'Italy'),
                        Questions(image: 'assets/images/7.jpg', title: 'Greece'),
                        Questions(image: 'assets/images/8.jpg', title: 'United States')
                      ],
                    ),
                  )),
                  SizedBox(height: 80,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return home();
  }
}


  Widget Groups({image, title}) {
    return AspectRatio(
      aspectRatio: 10/9.3,
      child: Container( 
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
              alignment: Alignment.topLeft,
              child: Text(title, style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),),
              ),
              Container(
                alignment: Alignment.topLeft,
                color: Colors.blue,
                    height: 40,
                    width: 40,
              ),
            ],
          ),
          // child: Align(
          //   alignment: Alignment.topLeft,
          //   child: Text(title, style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),),
          // ),
          
        ), // this is responsible for the inside
      ), // overall container
    );
  }

  Widget Questions({image, title}) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child:  Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xF1C40F),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Color(0xF1C40F).withOpacity(1), //Colors.black.withOpacity(.8),
                Color(0xF1C40F).withOpacity(1), //Colors.black.withOpacity(.2),
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             



              // Align(
              // alignment: Alignment.topLeft,
              // child: Text(title, style: GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),),
              // ),
              // Container(
              //   alignment: Alignment.topLeft,
              //   color: Colors.blue,
              //       height: 40,
              //       width: 40,
              // ),
            ],
          ),
          
        ),
       // this is responsible for the inside
      ), // overall container
    );
  }