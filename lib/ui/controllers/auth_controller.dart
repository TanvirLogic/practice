import 'dart:convert';

import '../../data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String _accessTokenKey = 'token';
  static const String _userModelkey = 'user-data';

  static String? accessToken;
  static UserModel? userModel;

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', token);
    await sharedPreferences.setString('user-data', jsonEncode(model.toJson()));
    accessToken = token;
    userModel = model;
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      String? userData = sharedPreferences.getString(_userModelkey);
      Map<String, dynamic> jsonData = jsonDecode(userData!);
      userModel = UserModel.fromJson(
        jsonData,
      ); // For saving in local variable of User Model class?
      accessToken = token;
    }
  }

  static Future<bool> isUserAlreadyLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if (token != null) {
      return true;
    }
    return false;
  }

  static Future<void> removeCacheStorgae() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
