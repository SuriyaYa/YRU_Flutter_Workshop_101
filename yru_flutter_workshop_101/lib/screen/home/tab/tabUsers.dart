import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/usersDao.dart';
import '../../../configApp.dart';

class TabUsers extends StatelessWidget {
  final Widget child;
  const TabUsers({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Users> usersList = [];
    return Container(
      // decoration: BackgroundYRU.decorationApp(),
      padding: new EdgeInsets.all(5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
            // new Expanded(child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text(usersList.name),
            //     SizedBox(height: 10.0,),
            //     Text(usersList.email),
            //   ],
            // ),),
            new Expanded(child: new Text(usersList.email),),

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