import 'package:buddyappfirebase/home/functionality/FirebaseFunctionality.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  FirebaseFunctionality _firebaseFunctionality = new FirebaseFunctionality();

  Future<FirebaseUser> getCurrentUser() =>
      _firebaseFunctionality.getCurrentUser();
  // Future<List<User>> getAllUsers(FirebaseUser user) =>
  //     _firebaseFunctionality.getAllUsers(user);
}
