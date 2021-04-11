import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/authLogin.dart';
import 'package:yru_flutter_workshop_101/screen/Login/components/background.dart';
import 'package:yru_flutter_workshop_101/screen/Signup/signup_screen.dart';
import 'package:yru_flutter_workshop_101/components/already_have_an_account_acheck.dart';
import 'package:yru_flutter_workshop_101/components/rounded_button.dart';
import 'package:yru_flutter_workshop_101/components/rounded_input_field.dart';
import 'package:yru_flutter_workshop_101/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yru_flutter_workshop_101/screen/home/homePage.dart';

import '../../../configApp.dart';
import '../../../saveData.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String userEmail = '';
    String userPassword = '';
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "เข้าใช้งาน",
              style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor,fontSize: 20.0),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "อีเมล",
              onChanged: (value) {
                userEmail = value;
                userEmail = userEmail.trim();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                userPassword = value;
                userPassword = userPassword.trim();
              },
            ),
            RoundedButton(
              text: "เข้าใช้งาน",
              press: () {
                LogDebug('$userEmail / $userPassword');

                // callApi(context,'suriya.ni@yru.ac.th', '123456');
                if(userEmail.isNotEmpty && userPassword.isNotEmpty) {
                  callApi(context,userEmail,userPassword);
                }else{
                  Fluttertoast.showToast(
                      msg: "กรุณากรอกข้อมูล",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                      fontSize: 20.0
                  );
                }

              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void callApi(BuildContext context,String user, String password) {
    ApiService.login(user,password).then((data) {
      LogDebug('data =  $data');
      if(data.toString().length > 3) {
        Map map = json.decode(data);
        AuthLogin dao = AuthLogin.fromJson(map);
        print('tokenType = ${dao.tokenType}');
        print('accessToken = ${dao.accessToken}');
        print('expiresIn = ${dao.expiresIn.toString()}');
        accessTokenSave = dao.accessToken.toString();
        SaveData.saveAccessToken(accessTokenSave);

        Fluttertoast.showToast(
            msg: "ลงชื่อเข้าใช้งานสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );



        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage(title: "Flutter Workshop")
        ),
        );
      }else{

      }
    }, onError: (error) {
      Fluttertoast.showToast(
          msg: "error: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0
      );
    }
    );
  }

}
