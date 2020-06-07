class HomeUser {
  String name;

  HomeUser({this.name});

  factory HomeUser.fromJson(Map<String, dynamic> parsedJson) {
    return HomeUser(
      name: parsedJson["country"] as String,
    );
  }
}