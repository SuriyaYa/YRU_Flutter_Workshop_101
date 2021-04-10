import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/screen/Login/login_screen.dart';
import 'package:yru_flutter_workshop_101/screen/Signup/signup_screen.dart';
import 'package:yru_flutter_workshop_101/screen/Welcome/components/background.dart';
import 'package:yru_flutter_workshop_101/components/rounded_button.dart';
import 'package:yru_flutter_workshop_101/configApp.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'YRU Flutter Workshop101\n'
                  '1/2564',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor,fontSize: 20.0),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "เข้าใช้งาน",
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
            RoundedButton(
              text: "สมัครสมาชิก",
              color: kPrimaryLightColor,
              textColor: Colors.black,
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
}
