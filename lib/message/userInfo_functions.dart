import 'package:shared_preferences/shared_preferences.dart';
class GetUserFunctions{

  static String sharedUserKey = "USERNAMEKEY";
  static String sharedEmailkey = "USEREMAILKEY";

  static Future<String> getUserNameWithSharedPref() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedUserKey);
  }
  static Future<String> getUserEmailWithSharedPref() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedEmailkey);
  }
}