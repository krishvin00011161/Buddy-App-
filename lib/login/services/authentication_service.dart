import 'package:buddyappfirebase/models/emailuser.dart';
import 'package:buddyappfirebase/services/firestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService { // Class that service sign in/up forget password
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirestoreService.createUser(EmailUser(
        id: authResult.user.uid,
        email: email,
      ));
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future recoverPasswordWithEmail({
    @required String email,
  }) async {
    try {
      var authResult = await _firebaseAuth.sendPasswordResetEmail(email: email);
      //return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }
}
