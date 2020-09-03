import 'package:cloud_firestore/cloud_firestore.dart';
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

  //Future<bool> authenticationUser(FirebaseUser user) async{
  //QuerySnapshot result = await firestore.collection("users").where("email", isEqualTo: user.email).getDocuments();
  // }

  // Future<List<User>> getAllUsers(FirebaseUser user) async {
  //   List<User> userList = List<User>();
  //   QuerySnapshot querySnapshot =
  //       await Firestore.instance.collection("users").getDocuments();
  //   for (var i; i < querySnapShot.documents.length; i++) {
  //     if (querySnapshot.documents[i].documentID != user.id) {
  //       userList.add(User.fromMap(querySnapshot.documents[i].data));
  //     }
  //     return userList;
  //   }
  // }
}
