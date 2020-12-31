/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Firebase Functionality
  Description: gets the current User;


 */

class User {
  String userName;
  String id;
  String timeStamp;
  String userEmail;
  String userRole;
  String photoUrl;
  User({
    this.userName,
    this.id,
    this.timeStamp,
    this.userEmail,
    this.userRole,
    this.photoUrl,
  });
  Map toUsers(User user) {
    var data = Map<String, dynamic>();
    data['userName'] = user.userName;
    data['id'] = user.id;
    data['timeStamp'] = user.timeStamp;
    data['userEmail'] = user.userEmail;
    data['userRole'] = user.userRole;
    data['photoUrl'] = user.photoUrl;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.userName = mapData['userName'];
    this.id = mapData['id'];
    this.timeStamp = mapData['timeStamp'];
    this.userEmail = mapData['userEmail'];
    this.userRole = mapData['userRole'];
    this.photoUrl = mapData['photoUrl'];
  }
}
