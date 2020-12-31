/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Firebase Functionality
  Description: gets the current User;


 */


import 'package:firebase_auth/firebase_auth.dart';
import 'package:buddyappfirebase/Message/models/user.dart';

class FirebaseFunctionality {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }


}
