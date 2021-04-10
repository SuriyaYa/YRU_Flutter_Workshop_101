import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/authLogin.dart';
import 'package:yru_flutter_workshop_101/screen/Login/components/background.dart';
import 'package:yru_flutter_workshop_101/screen/Login/login_screen.dart';
import 'package:yru_flutter_workshop_101/screen/Signup/signup_screen.dart';
import 'package:yru_flutter_workshop_101/components/already_have_an_account_acheck.dart';
import 'package:yru_flutter_workshop_101/components/rounded_button.dart';
import 'package:yru_flutter_workshop_101/components/rounded_input_field.dart';
import 'package:yru_flutter_workshop_101/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

import '../../../configApp.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "สถานะ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/login.svg",
            //   height: size.height * 0.35,
            // ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "-",
              onChanged: (value) {},
            ),
            FutureBuilder(
                            future: ApiService.login('hosea46@example.com', 'password'),
                            builder: (context, AsyncSnapshot<String> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting)
                                return Center(child: CircularProgressIndicator());
                              else if (snapshot.hasData)
                                return Text("DATA: ${snapshot.data}");
                              else if (snapshot.hasError)
                                return Text("ERROR: ${snapshot.error}");
                              else
                                return Text('None');
                            }
                        ),
            RoundedButton(
              text: "เช็คสถานะ",
              press: () {
                _callApi();
                // FutureBuilder(
                //     future: ApiService.login('hosea46@example.com', 'password'),
                //     builder: (context, AsyncSnapshot<String> snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting)
                //         return Center(child: CircularProgressIndicator());
                //       else if (snapshot.hasData)
                //         return Text("DATA: ${snapshot.data}");
                //       else if (snapshot.hasError)
                //         return Text("ERROR: ${snapshot.error}");
                //       else
                //         return Text('None');
                //     }
                // );
              },
            ),
            SizedBox(height: size.height * 0.03),
            // AlreadyHaveAnAccountCheck(
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) {
            //           return LoginScreen();
            //         },
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }



  void _callApi() {
    ApiService.login('hosea46@example.com', 'password1').then((data) {
      LogDebug('weather : ${data.toString()}');
    }, onError: (error) {

    }
    );
  }

}
