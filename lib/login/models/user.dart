
import 'package:cloud_firestore/cloud_firestore.dart';
 // Place where fields are init for google users
class User { 

  // final DateTime timestamp = DateTime.now();

  // final String id;
  // final String fullName;
  // final String email;
  // final String userRole;

  // final HashMap<String, String> classes = HashMap();


  // GoogleUser({
  //   this.id, 
  //   this.fullName, 
  //   this.email, 
  //   this.userRole
    
  // });

  // GoogleUser.fromData(Map<String, dynamic> data)
  //     : id = data['id'],
  //       fullName = data['fullName'],
  //       email = data['email'],
  //       userRole = data['userRole'];

        
  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'fullName': fullName,
  //     'email': email,
  //     'userRole': userRole,
  //     'timestamp' : timestamp,
  //     'classes' : classes,
  //   };
  // }
  final DateTime timeStamp = DateTime.now();
  //User used when creating new credential in firebase
  final String classes;
  final String email;
  final String fullName;
  final String id;
  final String photoUrl;
  final String timestamp;
  final String userRole;
  final String displayName;

  User({
    this.classes,
    this.email,
    this.fullName,
    this.id,
    this.photoUrl,
    this.timestamp,
    this.userRole,
    this.displayName
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      classes: doc['classes'],
      email: doc['email'],
      fullName: doc['displayName'], // how does this work
      id: doc['id'],
      photoUrl: doc['photoUrl'],
      userRole: doc['userRole'],
      timestamp: doc['timestamp']
    );
  }
}