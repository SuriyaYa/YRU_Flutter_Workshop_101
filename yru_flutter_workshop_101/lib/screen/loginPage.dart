import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/CatDao.dart';
import 'package:yru_flutter_workshop_101/model/authLogin.dart';
import 'package:yru_flutter_workshop_101/screen/usersPage.dart';

import '../configApp.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key key, this.title}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/images/flutter-logo.png')),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
                onChanged: (text) {
                  user = text;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(

                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
                onChanged: (text) {
                  password = text;
                },
              ),
            ),
            FlatButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () {
                  LogDebug('Press authLoginApp u:$user , p:$password');
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (_) => MyApp()));
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => UsersPage(title: "User")
                  ),
                  );
                  authLoginApp();
                  setState(() {
                    user = '';
                    password = '';
                  });
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
            Text('New User? Create Account')
          ],
        ),
      ),
    );
  }

  authLoginApp(){
    LogDebug('authLoginApp');
        FutureBuilder(
            future: ApiService.randomCat(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('${snapshot.data}');
                CatDao dao = snapshot.data;
                print('link = ${dao.link.toString()}');
                return Image.network(dao.link,width: 300,height: 200,);
              } else {
                return CircularProgressIndicator();
              }
            }
        );
        FutureBuilder(
            future: ApiService.login('metz.serena@example.net', 'password'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('login ${snapshot.data}');
                Map map = json.decode(snapshot.data);
                AuthLogin dao = AuthLogin.fromJson(map);
                print('tokenType = ${dao.tokenType}');
                print('accessToken = ${dao.accessToken}');
                print('expiresIn = ${dao.expiresIn.toString()}');
                return Text('');
              } else {
                return CircularProgressIndicator();
              }
            }
        );
        // FutureBuilder(
        //     future: ApiService.allUser(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         Map map = json.decode(snapshot.data);
        //         UsersDao dao = UsersDao.fromJson(map);
        //         print('currentPage = ${dao.data.currentPage}');
        //         print('name = ${dao.data.dataProfile[0].name}');
        //         // print('expiresIn = ${dao.expiresIn.toString()}');
        //         return Text('');
        //       } else {
        //         return CircularProgressIndicator();
        //       }
        //     }
        // );
  }

}