import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yru_flutter_workshop_101/screen/centerPage.dart';
import 'package:yru_flutter_workshop_101/screen/loginPage.dart';
import 'package:yru_flutter_workshop_101/screen/welcome/welcome_screen.dart';

import 'api/apiService.dart';
import 'configApp.dart';
import 'model/authLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(title: 'YRU Flutter Workshop 101'),
      home: WelcomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    delayPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        // title: Text(widget.title),
      // ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'YRU Flutter Workshop 101\n(Splash Screen)',
                  style: TextStyle(fontSize: 28,color: Colors.blue),textAlign: TextAlign.center,
              ),
              FutureBuilder(
                  future: ApiService.login('hosea46@example.com', 'password'),
                  builder: (contextUser, snapshot) {
                    // print('authLoginApp status: ${snapshot.data}');
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  delayPage() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessTokenSave = prefs.getString('yru_access_token') ;

    Timer(Duration(seconds: 3), () {
      if(userAuth != null)
        if(userAuth){
          try {
            LogDebug("Delay => Home");
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => LoginPage(title: "Login > 2")
            ),
            );
          } on Exception catch (exception) {
            LogDebug('Delay => Home Exception: $exception');
          } catch(Error){
            LogDebug('Delay => Home Error: $Error');
          }
        }else{
          try {
            LogDebug("Delay => IntroScreen");
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CenterPage(title: "Null")
            ),
            );
          } catch(Error){
            LogDebug('Delay => IntroScreen Error: $Error');
          }
        }
    });
  }

}
