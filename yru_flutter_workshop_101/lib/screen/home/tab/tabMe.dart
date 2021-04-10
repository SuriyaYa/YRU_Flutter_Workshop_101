import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/meDao.dart';

import '../../../configApp.dart';

class TabMe extends StatelessWidget {
  final Widget child;
  const TabMe({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder(
                                future: ApiService.me(accessTokenSave),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    print('${snapshot.data}');
                                    return layoutHomePage(snapshot.data);
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

  layoutHomePage(String data){

    Map map = json.decode(data);
    MeDao dao = MeDao.fromJson(map);

    return new Column(
      children: [
        ListTile(
          title: Text('${dao.name}'),
          leading: Icon(Icons.people),
          onTap: (){
            print('Touch List 0');
          },
        ),
        ListTile(
          title: Text('0812345678'),
          leading: Icon(Icons.phone),
          onTap: (){
            print('Touch List 0');
          },
        ),
        ListTile(
          title: Text('${dao.email}'),
          leading: Icon(Icons.email),
          onTap: (){
            print('Touch List 0');
          },
        ),
        ListTile(
          title: Text('${dao.createdAt}'),
          leading: Icon(Icons.create),
          onTap: (){
            print('Touch List 0');
          },
        ),
        ListTile(
          title: Text('${dao.updatedAt}'),
          leading: Icon(Icons.update),
          onTap: (){
            print('Touch List 0');
          },
        ),
        ListTile(
          title: Text('ออกจากระบบ'),
          leading: Icon(Icons.logout),
          onTap: (){
            print('Touch Exit');
          },
        ),
      ],
    );

  }

}
