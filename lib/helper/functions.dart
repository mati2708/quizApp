import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String UserLoggedInKey = "USERLOGGEDINKEY";

 static saveUserLoggedInDetails({required bool isLoggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(UserLoggedInKey, isLoggedin);
  }

static Future<bool> getUserLoggedInDetails ({required bool isLoggedin}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool(UserLoggedInKey) ?? false;
}

}