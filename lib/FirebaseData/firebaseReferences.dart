
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReferences {
  static final usersRef = Firestore.instance.collection('users');
  static final questionsRef = Firestore.instance.collection('questions');
}