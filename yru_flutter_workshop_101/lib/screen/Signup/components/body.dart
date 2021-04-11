import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/screen/Login/login_screen.dart';
import 'package:yru_flutter_workshop_101/screen/Signup/components/background.dart';
import 'package:yru_flutter_workshop_101/screen/Signup/components/or_divider.dart';
import 'package:yru_flutter_workshop_101/screen/Signup/components/social_icon.dart';
import 'package:yru_flutter_workshop_101/components/already_have_an_account_acheck.dart';
import 'package:yru_flutter_workshop_101/components/rounded_button.dart';
import 'package:yru_flutter_workshop_101/components/rounded_input_field.dart';
import 'package:yru_flutter_workshop_101/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configApp.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String getName = '';
    String getPhoneNumber = '';
    String getEmail = '';
    String getPassword = '';
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "สมัครสมาชิก",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "ชื่อ-สกุล",
              onChanged: (value) {
                getName = value;
                getName = getName.trim();
              },
            ),
            RoundedInputField(
              hintText: "เบอร์โทรศัพท์",
              onChanged: (value) {
                getPhoneNumber =value;
                getPhoneNumber.trim();
              },
            ),
            RoundedInputField(
              hintText: "อีเมล",
              onChanged: (value) {
                getEmail = value;
                getEmail = getEmail.trim();
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                getPassword = value;
                getPassword = getPassword.trim();
              },
            ),
            RoundedButton(
              text: "สมัครสมาชิก",
              press: () {
                LogDebug('$getName / $getPhoneNumber / $getEmail / $getPassword');

                // callApi(context,'name','098','hosea46@example.com', 'password');
                if(getName.isNotEmpty && getPhoneNumber.isNotEmpty && getEmail.isNotEmpty && getPassword.isNotEmpty) {
                  LogDebug('callApi register >>> 1');
                  callApi(context,getName,getPhoneNumber,getEmail,getPassword);
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
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void callApi(BuildContext context,String name, String phone, String user, String password) {
    LogDebug('callApi register >>>');
    ApiService.signUp(name, phone, user, password).then((data) {
      LogDebug('data =  $data');
      if(data.toString().length > 3) {
        // Map map = json.decode(data);
        // RegisterDao dao = RegisterDao.fromJson(map);
        // print('name = ${dao.data.name}');
        // print('email = ${dao.data.email}');
        // print('emailVerifiedAt = ${dao.data.emailVerifiedAt}');

        Fluttertoast.showToast(
            msg: "สมัครสมาชิกสำเร็จสำเร็จ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 20.0
        );



        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => LoginScreen()
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
