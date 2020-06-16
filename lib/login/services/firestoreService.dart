import 'package:buddyappfirebase/login/models/emailuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Service the creating emailusers in firebase
// Dk

class FirestoreService { 
  static final CollectionReference usersCollectionReference =
      Firestore.instance.collection("users");
  static String id;
  static Future createUser(EmailUser user) async {
    try {
      await usersCollectionReference.document(user.id).setData(user.toJson());
      id = user.id;
    } catch (e) {
      return e.message;
    }
  }

}