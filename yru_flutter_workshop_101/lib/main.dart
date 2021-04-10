import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yru_flutter_workshop_101/screen/centerPage.dart';
import 'package:yru_flutter_workshop_101/screen/loginPage.dart';
import 'package:yru_flutter_workshop_101/screen/usersPage.dart';

import 'configApp.dart';

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
      home: MyHomePage(title: 'YRU Flutter Workshop 101'),
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

            ],
          ),
        ),
      ),
    );
  }

  delayPage(){
    Timer(Duration(seconds: 5), () {
      if(userAuth != null)
        if(userAuth){
          try {
            LogDebug("Delay => Home");
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(
            //     builder: (context) => LoginPage(title: "Login")
            // ),
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => LoginPage(title: "Login")
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
