import 'package:buddyappfirebase/login/ui/shared/ui_helpers.dart';
import 'package:buddyappfirebase/login/ui/views/login_view.dart';
import 'package:buddyappfirebase/login/ui/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class StartView extends StatefulWidget {
  @override
  _StartViewState createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // frog man
            Image(
              width: 150,
              height: 400,
              image: NetworkImage("https://thumbs.gfycat.com/PinkOldfashionedCarpenterant-small.gif"),
            ),
            verticalSpaceMassive,

            // Log In
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 80,
              child: RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginView(),
                    ),
                  );
                },
                child: Text(
                  'LOG IN',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Sign Up
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 80,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          SignUpView(),
                    ),
                  );
                },
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );



//    return ViewModelProvider<LoginViewModel>.withConsumer(
//      viewModel: LoginViewModel(),
//      builder: (context, model, child) => Scaffold(
//          backgroundColor: Colors.white,
//          body: SingleChildScrollView(
//            padding: const EdgeInsets.symmetric(horizontal: 50),
//            child: Column(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//
//              ],
//            ),
//          )),
//    );
  }
}
