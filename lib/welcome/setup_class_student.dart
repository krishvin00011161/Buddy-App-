import 'dart:collection';
import 'package:buddyappfirebase/Authentication/screens/signup.dart';
import 'package:buddyappfirebase/home/screens/MainHomeView.dart';
import 'package:buddyappfirebase/home/widgets/ui_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// This is for students setup

class SetUpStudent extends StatefulWidget {
  @override
  _SetUpStudentState createState() => _SetUpStudentState();
}

class _SetUpStudentState extends State<SetUpStudent> {
  TextEditingController className = new TextEditingController();
  TextEditingController classCode = new TextEditingController();
  String documentID;

  getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpaceLarge,
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.blueAccent,
              padding: EdgeInsets.fromLTRB(0, 0, 75, 0),
              onPressed: () {
                Navigator.pop(context); // Go back
              },
            ),
            verticalSpaceLarge,
            TextFormField(
              //Todo  Have to change the outline of textfield to blue
              controller: className,
              decoration: InputDecoration(
                  labelText: 'Class Name',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please make a class code.';
                }
              },
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: classCode,
              decoration: InputDecoration(
                  labelText: 'Class Code',
                  labelStyle: TextStyle(
                    color: Colors.blueAccent,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please make a class code.';
                }
              },
              obscureText: false,
            ),
            verticalSpaceMedium,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: displayFinish == false,
                  child: FlatButton(
                    child: Text(
                      'JOIN CLASS',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blueAccent,
                    padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    onPressed: () async {
                      updateInfo(false);
                    },
                  ),
                ),
                Visibility(
                  visible: displayFinish == true,
                  child: FlatButton(
                    child: Text(
                      'FINISH',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blueAccent,
                    padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    onPressed: () async {
                      // Checks if class name or code is empty, if so, asks if user wants to continue
                      if (className.text == '' || classCode.text == ''){
                        // set up yes button, finishes setup
                        Widget yesButton = FlatButton(
                          child: Text("Yes"),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => MainHomeView()),
                            );
                          },
                        );

                        // set up no button, goes back to setup
                        Widget noButton = FlatButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );

                        // set up the confirmation
                        AlertDialog confirm = AlertDialog(
                          title: Text("Complete Setup"),
                          content: Text("Are you sure you are done joining classes?"),
                          actions: [
                            noButton,
                            yesButton,
                          ],
                        );

                        // show the confirmation
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return confirm;
                          },
                        );
                      } else {
                        updateInfo(false);
                      }
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text(
                    'ADD CLASSES',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.fromLTRB(75, 12, 75, 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                  onPressed: () async {
                    updateInfo(true);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Shows the finish and hides the join class button if true
  bool displayFinish = false;

  // Needs to know how
  // changed to AuthService.idNew
  //gets info from input and updates firestore
  void updateInfo(bool addClass) async{
    final HashMap<String, String> classes = HashMap();

    // checks if class exists and if class code is correct
    DocumentReference documentReference =
        Firestore.instance.collection("classes").document(className.text);
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists && datasnapshot.data['code'] == classCode.text) {
        // adds class for user
        classes[className.text] = classCode.text;
        Firestore.instance
            .collection('users')
            .document(SignUp.documentID) // changed AuthService.idNew
            .updateData({'classes': classes});
        Firestore.instance
            .collection('users')
            .document(SignUp.documentID) // changed
            .updateData({'userRole': 'student'});

        // adds user's id to the class's user array
        Firestore.instance
            .collection('classes')
            .document(className.text)
            .updateData({
          "users": FieldValue.arrayUnion([SignUp.documentID]) // changed // important
        }); // this works

        // This is a stupid way of doing this but the other way doesn't work for some reason
        // Checks to see if the button that was pressed is join class or if it's add another class
        if (addClass) {
          // Clears input boxes
          className.clear();
          classCode.clear();

          // sets up alert
          AlertDialog success = AlertDialog(
            title: Text("Success!"),
            content: Text(
                "Your class has been added. Add another one."),
          );

          // displays alert
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return success;
            },
          );

          // Displays the finish button to replace the join class button
          displayFinish = true;
          setState(() {});

        }else {
          // If user selects join class, takes them to the home page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainHomeView()),
          );
        }
      } else {
        // If class cannot be found, show an error
        AlertDialog wrongCode = AlertDialog(
          title: Text("Class not found"),
          content: Text(
              "Please make sure the class name and the class code are correct."),
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return wrongCode;
          },
        );
      }
    });
  }
}
