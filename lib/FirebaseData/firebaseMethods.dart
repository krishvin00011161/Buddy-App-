import 'package:buddyappfirebase/FirebaseData/firebaseReferences.dart';
import 'package:buddyappfirebase/GlobalWidget/constants.dart';
import 'package:buddyappfirebase/GlobalWidget/helperfunctions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {
  static String profileImgUrl = "";
  static String userName = "";
  static List questionValues = [];
  static int amountOfQuestions;
  static Map classValues = {};
  static int amountOfClasses = 0;
  static String email;
  

   // This gets the profile Img url
  getUserProfileImg() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference();
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
    if (doc.data["photoUrl"] != null) {
      profileImgUrl = doc.data['photoUrl'];
      
    }
  }

  // getUsername 
  getUserName() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot doc =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
    if (doc.data["userName"] != null) {
      userName = doc.data['userName'];
    }
  }

  // gets question from firebase
  getUserQuestions() async {
    Constants.myId = await HelperFunctions
        .getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot docQuestion =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
      if (docQuestion.data['questions'] != null) {
        questionValues = docQuestion.data["questions"];
        amountOfQuestions = questionValues.length;
      } else {
        amountOfQuestions = 0;
      }
  }

  // gets classes
  getUserClasses() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot docClasses =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
      if (docClasses.data['classes'] != null) {
        classValues = docClasses.data["classes"];
        amountOfClasses = classValues.length;
      }
  }

  getUserEmail() async {
    Constants.myId = await HelperFunctions.getUserIDSharedPreference(); // Gets user ID saved from Sign Up
    final DocumentSnapshot docEmail =
        await FirebaseReferences.usersRef.document(Constants.myId).get();
      if (docEmail.data['userEmail'] != null) {
        email = docEmail.data["userEmail"];
        
      }
  }


}