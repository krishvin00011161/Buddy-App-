
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationService { 
  // Class that service sign in/up forget password
  // Dk

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final DateTime timestamp = DateTime.now();

  Future loginWithEmail({ 
    // This is called like Model.login(email, password)
    // It is responsible of doing backend work when the login With Email button is pressed
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
    // This is called like Model.signUpWIthEmail(email, password)
    // It is responsible of doing backend work when the login With Email button is pressed
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // await FirestoreService.createUser(EmailUser( // where i call it very important
      //   id: authResult.user.uid,
      //   email: email,
      //   fullName: fullName,
      // ));
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
