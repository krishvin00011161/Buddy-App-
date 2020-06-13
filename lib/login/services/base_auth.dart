import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String username, String email, String password);
  Future<void> signOut();
}
  // This class uses Authentication_Service functions.
  // Dk
class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<String> signUp(String username, String email, String password) async { // This function do SignUp which create User to firebase
    AuthResult user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    try {
      await user.user.sendEmailVerification(); 
      return user.user.uid;
    } catch (e) {
      print("An error occured while trying to send email        verification");
      print(e.message);
    }
  }

  @override
  Future<String> signIn(String email, String password) async { // This function do sighin users
    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user.user.isEmailVerified) return user.user.uid;
    return null;
  }

  @override
  Future<void> signOut() { // This fucntions signs it out
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future resetPassword(String email) async { // Reset password
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
