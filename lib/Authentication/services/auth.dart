import 'package:buddyappfirebase/Message/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


// This needs work

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static String idNew;
  static String id;
  static String errormessage = "";


  // Gets the user form Firebase
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, id: user.providerId) : null;
  }

  // Sign in functionality
  Future signInWithEmailAndPassword(String email, String password) async {
    // Sign In should not look at this.
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // Sign Up functionality
  Future signUpWithEmailAndPassword(
      String email, String password, User user) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      idNew = user.uid;
      id = result.user.providerId;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      AuthService.errormessage = e.String();
      return null;
    }
  }

  // Reset password functionality 
  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
