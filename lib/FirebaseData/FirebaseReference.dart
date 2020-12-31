/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Firebase Reference
  Description: Helps with Firebase reference


 */

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReferences {
  static final usersRef = Firestore.instance.collection('users');
  static final questionsRef = Firestore.instance.collection('questions');
}