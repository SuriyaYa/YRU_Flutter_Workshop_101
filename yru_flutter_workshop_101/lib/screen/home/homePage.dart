import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/CatDao.dart';
import 'package:yru_flutter_workshop_101/model/meDao.dart';
import 'package:yru_flutter_workshop_101/model/usersDao.dart';
import 'package:yru_flutter_workshop_101/screen/home/tab/tabMe.dart';
import 'package:yru_flutter_workshop_101/screen/home/tab/tabPosts.dart';
import 'package:yru_flutter_workshop_101/screen/home/tab/tabUsers.dart';

import '../../configApp.dart';

class HomePage extends StatefulWidget {

  final String title;

  const HomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Text('หน้าหลัก', style: TextStyle(fontSize: 18.0)),
                Text('ผู้ใช้ทั้งหมด', style: TextStyle(fontSize: 18.0)),
                Text('ฉัน', style: TextStyle(fontSize: 18.0)),
              ],
            ),
            title: Text(widget.title),
          ),
          body: TabBarView(
            children: [
              TabPosts(),
              TabUsers(),
              TabMe(),
            ],
          ),
        ),
      ),
    );
  }
  ///Tab 1
  tabHome() {
    return Container(
      padding: new EdgeInsets.all(16.0),
      child: ListView(
        // padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.all(5.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue, // background
                              ),
                              child: Text('Refresh'),
                              onPressed: () {
                                setState(() {

                                });
                              },
                            ),
                            SizedBox(height: 10),
                            FutureBuilder(
                                future: ApiService.posts(accessTokenSave),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print('${snapshot.data}');
                                    return Text('');
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                }
                            ),
                          ]
                      )
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }

}

