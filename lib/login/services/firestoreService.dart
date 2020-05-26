import 'package:buddyappfirebase/models/emailuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService { // Service the creating users in firebase
  static final CollectionReference usersCollectionReference =
      Firestore.instance.collection("users");
  static Future createUser(EmailUser user) async {
    try {
      await usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

}