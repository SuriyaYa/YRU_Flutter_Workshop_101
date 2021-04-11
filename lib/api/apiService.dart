import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:yru_flutter_workshop_101/configApp.dart';
import 'package:yru_flutter_workshop_101/model/CatDao.dart';
import 'package:yru_flutter_workshop_101/model/errorDao.dart';


class ApiService {

  static Future<String> login(String email, String password) async {
    var url = Uri.https(yru_service, api_login, {'q': '{http}'});
    String _json = '{"email": "$email", "password": "$password"}';
    var response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "Authorization": "$userTokenType $userAccessToken",
    }, body: _json);

    LogDebug('Request url: $url');
    LogDebug('Request body: $_json');
    LogDebug('response statusCode: ${response.statusCode}');

    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else if (response.statusCode == 201) {
      LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      Map map = json.decode(response.body.toString());
      ErrorDao dao = ErrorDao.fromJson(map);
      Fluttertoast.showToast(
          msg: "${response.statusCode} ${dao.error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0
      );
      return response.statusCode.toString();
    }
  }

  static Future<String> signUp(String name, String phone, String email, String password) async {
    var url = Uri.https(yru_service, api_signUp, {'q': '{http}'});
    String _json = '{"name": "$name","phone": "$phone","email": "$email", "password": "$password"}';
    var response = await http.post(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      // "Authorization": "$userTokenType $userAccessToken",
    }, body: _json);

    LogDebug('Request url: $url');
    LogDebug('Request body: $_json');
    LogDebug('response statusCode: ${response.statusCode}');

    if (response.statusCode == 200) {
      LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else if (response.statusCode == 201) {
      LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else if (response.statusCode == 422) {
      LogDebug('response: ${response.body.toString()}');
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      // Map map = json.decode(response.body.toString());
      // Error2Dao dao = Error2Dao.fromJson(map);
      Fluttertoast.showToast(
          msg: "${response.body.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0
      );
      return response.statusCode.toString();
    }else {
      LogDebug('response: ${response.body.toString()}');
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      Map map = json.decode(response.body.toString());
      ErrorDao dao = ErrorDao.fromJson(map);
      Fluttertoast.showToast(
          msg: "${response.statusCode} ${dao.error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0
      );
      return response.statusCode.toString();
    }
  }

  static Future<String> posts(String userAccessToken) async {
    LogDebug('Request post: $userAccessToken');
    var url = Uri.https(yru_service, api_posts, {'q': '{http}'});
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userAccessToken",
    });

    LogDebug('Request url: $url');
    LogDebug('response statusCode: ${response.statusCode}');

    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else if (response.statusCode == 201) {
      LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      Map map = json.decode(response.body.toString());
      ErrorDao dao = ErrorDao.fromJson(map);
      Fluttertoast.showToast(
          msg: "${response.statusCode} ${dao.error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0
      );
      return response.statusCode.toString();
    }
  }

  static allUser(String userAccessToken) async {
    LogDebug('Request allUser >>');
    var url = Uri.https(yru_service, api_user, {'q': '{http}'});
    LogDebug('Request url allUser: $url');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userAccessToken",
    });
    LogDebug('Request url allUser: $url');
    LogDebug('response statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      Map map = json.decode(response.body.toString());
      ErrorDao dao = ErrorDao.fromJson(map);
      Fluttertoast.showToast(
          msg: "${response.statusCode} ${dao.error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0
      );
      return response.statusCode.toString();
    }
  }

  static me(String  userAccessToken) async {
    LogDebug('Request me >>');
    var url = Uri.https(yru_service, api_me, {'q': '{http}'});
    LogDebug('Request url me: $url');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $userAccessToken",
    });
    LogDebug('Request url me: $url');
    LogDebug('response statusCode: ${response.statusCode}');
    if (response.statusCode == 200) {
      // LogDebug('response: ${response.body.toString()}');
      return response.body.toString();
    } else {
      LogDebug(
          'Request failed with status: ${response.statusCode} \n ${response.body
              .toString()}');
      return response.statusCode.toString();
    }
  }

  static randomCat() async {
    var url = Uri.https('some-random-api.ml', '/img/cat', {'q': '{http}'});
    var response = await http.get(url, headers:  {
        "Content-Type": "application/json",
        "Accept": "application/json",
      }
    );

    print('Request url: $url');
    if (response.statusCode == 200) {
      Map map = json.decode(response.body);
      CatDao dao = CatDao.fromJson(map);
      // print("URL link = " + dao?.link);
      return response.statusCode.toString();
    }
  }

}