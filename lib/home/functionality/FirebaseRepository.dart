/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Firebase Functionality
  Description: gets the current User;


 */

import 'package:buddyappfirebase/home/functionality/FirebaseFunctionality.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  FirebaseFunctionality _firebaseFunctionality = new FirebaseFunctionality();

  Future<FirebaseUser> getCurrentUser() =>
      _firebaseFunctionality.getCurrentUser();

}
