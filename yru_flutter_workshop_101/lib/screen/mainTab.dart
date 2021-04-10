import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/CatDao.dart';
import 'package:yru_flutter_workshop_101/model/meDao.dart';
import 'package:yru_flutter_workshop_101/model/usersDao.dart';

import '../configApp.dart';

class UserInfo extends StatefulWidget {

  final String title;

  const UserInfo({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserInfoState();
  }
}

class _UserInfoState extends State<UserInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Text('Home', style: TextStyle(fontSize: 18.0)),
                Text('List User', style: TextStyle(fontSize: 18.0)),
                Text('User Info', style: TextStyle(fontSize: 18.0)),
              ],
            ),
            // title: Text('menu_virtual_card'.tr),
          ),
          body: TabBarView(
            children: [
              tabHome(),
              tabListUser(),
              tabInfo(),
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
                      padding: new EdgeInsets.all(10.0),
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
                                future: ApiService.randomCat(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print('${snapshot.data}');
                                    CatDao dao = snapshot.data;
                                    // print('link = ${dao.link.toString()}');
                                    return Image.network(
                                      dao.link, width: 300, height: 200,);
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

  ///Tab 2
  tabListUser() {
    List<Users> usersList = [];
    return Container(
      // decoration: BackgroundYRU.decorationApp(),
      padding: new EdgeInsets.all(5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('List user', style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18.0,),
              textAlign: TextAlign.start),
          SizedBox(height: 20.0,),
          new Expanded(
              child: FutureBuilder(
                  future: ApiService.allUser(accessTokenSave),
                  builder: (context, data) {
                    if (data.hasData) {
                      // LogDebug('data display= ${data.data}');

                      if (data.data != '' && data.data
                          .toString()
                          .length > 3) {
                        Map map = json.decode(data.data);
                        UsersDao dao = UsersDao.fromJson(map);
                        print('currentPage = ${dao.currentPage}');
                        print('name = ${dao.data[0].name}');

                        // List<dynamic> list = json.decode(data.data)['data']
                        //     .map((data) => UsersDao.fromJson(data))
                        //     .toList();

                        List<dynamic> list = dao.data;

                        LogDebug('list = ${list.length}');
                        if (usersList != null) {
                          LogDebug('usersList != null');
                          usersList = null;
                          usersList = [];
                        }
                        for (var i = 0; i < list.length; i++) {
                          usersList.add(new Users(
                              '${dao.data[i].id}', '${dao.data[i].name}',
                              '${dao.data[i].email}',
                              '${dao.data[i].createdAt}',
                              '${dao.data[i].updatedAt}'));
                        }
                        return new ListView(
                          padding: new EdgeInsets.symmetric(
                              vertical: 1.0),
                          children: usersList.map((Users usersList) {
                            return new UsersItemList(usersList);
                          }).toList(),
                        );
                      } else {
                        return Text('');
                      }
                    } else {
                      // return CircularProgressIndicator();
                      return Text('');
                    }
                  }
              )),


        ],
      ),
    );
  }

  ///Tab 3
  tabInfo() {
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
                      padding: new EdgeInsets.all(10.0),
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
                                future: ApiService.me(accessTokenSave),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print('${snapshot.data}');
                                    return layoutUserInfo(snapshot.data);
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

  layoutUserInfo(String data){

    Map map = json.decode(data);
    MeDao dao = MeDao.fromJson(map);

    return new Column(
      children: [
        Text('name'),
        Text('Name : ${dao.name}'),
        Text('Email : ${dao.email}'),
      ],
    );

  }

}


///For Tab ListUser
class UsersItemList extends StatefulWidget {
  final Users usersList;
  UsersItemList(Users usersList)
      : usersList = usersList,
        super(key: new ObjectKey(usersList));
  @override
  UsersItemState createState() {
    return new UsersItemState(usersList);
  }
}

class UsersItemState extends State<UsersItemList> {
  final Users usersList;
  UsersItemState(this.usersList);
  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new ListTile(
        title: new Row(
          children: <Widget>[
            new Expanded(child: new Text(usersList.name),),
            new Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(usersList.name),
                SizedBox(height: 10.0,),
                Text(usersList.email),
              ],
            ),),
            // new Expanded(child: new Text(usersList.email),),

          ],
        ),
        onTap: () => onTapped(usersList),
      ),
    );
  }

  void onTapped(Users select) {
    // navigate to the next screen.
    LogDebug('Edit name: ${select.name}');
  }
}

class Users {
  String id;
  String name;
  String email;
  String created_at;
  String updated_at;
  Users(this.id, this.name, this.email, this.created_at, this.updated_at);
}