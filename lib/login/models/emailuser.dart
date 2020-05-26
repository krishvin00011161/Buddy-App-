class EmailUser { // Class for Email user when creating new user throw firebase
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  EmailUser({this.id, this.fullName, this.email, this.userRole});
  EmailUser.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
    };
  }
}