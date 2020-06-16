


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user.dart';



// Service the creating emailusers in firebase
// Dk

// class GoogleFirestoreService { 
//   static final CollectionReference usersCollectionReference =
//       Firestore.instance.collection("users");
//   static String id;
//   static Future createGoogleUser(GoogleUser user) async {
//     try {
//       await usersCollectionReference.document(user.id).setData(user.toJson());
//       id = user.id;
//     } catch (e) {
//       return e.message;
//     }
//   }

// }

class GooglefirestoreService { 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = new GoogleSignIn();
  final usersRef = Firestore.instance.collection('users');
  final DateTime timestamp = DateTime.now();
  User currentUser;

  createUserInFirestore(String classes, String userRole) async {
    // 1) check if user exists in users collection in database (according to their id)
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.document(user.id).get();

    if (!doc.exists) {
      // 2) if the user doesn't exist, then we want to take them to the create account page

      final FirebaseUser googleUser = await _auth.currentUser();
      final uid = googleUser.uid;
      // 3) get username from create account, use it to make new user document in users collection
      usersRef.document(user.id).setData({
        "classes" : classes,
        "email": user.email,
        "fullName": user.displayName,
        "id": uid,
        "photoUrl": user.photoUrl,
        "userRole": userRole,
        "timestamp": timestamp
      });

      doc = await usersRef.document(user.id).get();
    }

    print(currentUser);
  }
  
}