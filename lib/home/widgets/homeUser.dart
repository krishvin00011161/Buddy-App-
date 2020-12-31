/* 
  Authors: David Kim, Aaron NI, Vinay Krisnan
  Date: 12/30/20

  Function: Search
  Description: Helps with Search


 */

class HomeUser {
  String name;

  HomeUser({this.name});

  factory HomeUser.fromJson(Map<String, dynamic> parsedJson) {
    return HomeUser(
      name: parsedJson["country"] as String,
    );
  }
}