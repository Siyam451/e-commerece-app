import 'dart:convert';

import 'package:ecommerce_project/app/features/auth/Data/Models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const _tokenKey = "access-token";
  static const _userKey = "user-data";

  static UserModel? userModel;
  static String? accessToken;

  static Future<void> saveUserData(String token,UserModel model,) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();

    await sharedPreferences.setString(_tokenKey, token);//future e data er upor nirbor tai await dichi
    await sharedPreferences.setString(
      _userKey,
      jsonEncode(model.toJson()),//user er jonno ekta korchi
    );

    accessToken = token;
    userModel = model;
  }

  static Future<void> getUserData()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_tokenKey);//getString() → আগে save করা token নিয়ে আসে
    if(accessToken!= null) {
      final String? UserData = sharedPreferences.getString(_userKey);
      if(UserData != null){
        userModel = UserModel.fromJson(jsonDecode(UserData));
      }
    }
  }


  static Future<bool> IsUserAlreadyLoggedIn()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_tokenKey) != null;
    
  }

  static Future<void> clearData()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
