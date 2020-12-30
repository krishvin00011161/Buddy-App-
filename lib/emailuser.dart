/* 
  Authors: David Kim
  Date: 12/30/20

  Function: Set up document structure in Firebase
  Description: It Set up the user portion of barebone document structure in Firebase


 */

import 'dart:collection';

class EmailUser {
  final DateTime timestamp = DateTime.now();
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  final String photoUrl;
  final HashMap<String, String> classes = HashMap();

  EmailUser({
    this.id,
    this.fullName,
    this.email,
    this.userRole,
    this.photoUrl,
  });

  EmailUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        photoUrl = data['photoUrl'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'timestamp': timestamp,
      'classes': classes,
      'photoUrl':
          "https://img.pngio.com/user-logos-user-logo-png-1920_1280.png",
    };
  }
}
