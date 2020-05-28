import 'package:cloud_firestore/cloud_firestore.dart';

class User { // User used when creating new credential in firebase
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String fullName;

  User({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.fullName,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
      fullName: doc['fullName'],
    );
  }
}