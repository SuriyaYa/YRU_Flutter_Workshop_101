
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveData {

  ///Save

  static saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('yru_access_token', accessToken);
  }

  static saveName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('yru_name', name);
  }

  static saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('yru_email', email);
  }

  ///Clear
  static clearUserToken(BuildContext context) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('yru_user_info', '');
    await prefs.setString('yru_user_info_mail', '');
    await prefs.setString('yru_user_info_microsoft', '');
    await prefs.setString('yru_user_token', '');
    await prefs.setString('yru_access_token', '');

  }

  ///Read
  static getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString('yru_access_token') ;
    return accessToken;
  }


}