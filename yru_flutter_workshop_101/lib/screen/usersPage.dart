import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yru_flutter_workshop_101/api/apiService.dart';
import 'package:yru_flutter_workshop_101/model/usersDao.dart';

import '../configApp.dart';
import '../saveData.dart';

class MainTap extends StatefulWidget {
  final String title;

  const MainTap({Key key, this.title}) : super(key: key);
  @override
  _MainTapState createState() => _MainTapState();
}

class _MainTapState extends State<MainTap> with WidgetsBindingObserver{



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    LogDebug('<<<<<<<<<<< state: ${state.toString()} >>>>>>>>>>');
    switch (state){
      case AppLifecycleState.inactive:
          LogDebug('<<<<<<<<<<< inactive >>>>>>>>>>');
        break;
      case AppLifecycleState.paused:
        LogDebug('<<<<<<<<<<< paused >>>>>>>>>>');
        break;
      case AppLifecycleState.resumed:
        LogDebug('<<<<<<<<<<< resumed >>>>>>>>>>');
        break;
      case AppLifecycleState.detached:
        LogDebug('<<<<<<<<<<< detached >>>>>>>>>>');
        break;

      default:
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LogDebug('<<<<<<<<<<< initState >>>>>>>>>>');

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    LogDebug('<<<<<<<<<<< dispose >>>>>>>>>>');
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    List<Device> deviceList = [];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),

        body: new Container(
          // decoration: BackgroundYRU.decorationApp(),
          padding: new EdgeInsets.all(5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('List user',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0,), textAlign: TextAlign.start),
              SizedBox(height: 20.0,),
              new Expanded(
                  child: FutureBuilder(
                      future: ApiService.allUser(accessTokenSave),
                      builder: (context, data) {
                        if(data.hasData){
                          // LogDebug('data display= ${data.data}');

                          if(data.data != '' && data.data.toString().length > 3) {

                            Map map = json.decode(data.data);
                            UsersDao dao = UsersDao.fromJson(map);
                            print('currentPage = ${dao.currentPage}');
                            print('name = ${dao.data[0].name}');

                            // List<dynamic> list = json.decode(data.data)['data']
                            //     .map((data) => UsersDao.fromJson(data))
                            //     .toList();

                            List<dynamic> list = dao.data;

                            LogDebug('list = ${list.length}');
                            if (deviceList != null) {
                              LogDebug('deviceList != null');
                              deviceList = null;
                              deviceList = [];
                            }
                              for (var i = 0; i < list.length; i++) {
                                deviceList.add(new Device(
                                    '${dao.data[i].id}', '${dao.data[i].name}', '${dao.data[i].email}','${dao.data[i].createdAt}','${dao.data[i].updatedAt}'));
                              }
                              return new ListView(
                                padding: new EdgeInsets.symmetric(
                                    vertical: 1.0),
                                    children: deviceList.map((Device deviceList) {
                                  return new DeviceItemList(deviceList);
                                }).toList(),
                              );

                          }else {
                            return Text('');
                          }
                        }else{
                          // return CircularProgressIndicator();
                          return Text('');
                        }
                      }
                  )),


            ],
          ),
        ),
    );
  }

}

class DeviceItemList extends StatefulWidget {
  final Device deviceList;
  DeviceItemList(Device deviceList)
      : deviceList = deviceList,
        super(key: new ObjectKey(deviceList));
  @override
  DeviceItemState createState() {
    return new DeviceItemState(deviceList);
  }
}

class DeviceItemState extends State<DeviceItemList> {
  final Device deviceList;
  DeviceItemState(this.deviceList);
  @override
  Widget build(BuildContext context) {
    return new Card(
        child: new ListTile(
          title: new Row(
            children: <Widget>[
              new Expanded(child: new Text(deviceList.name),),
              new Expanded(child: new Text(deviceList.email),),

            ],
          ),
          onTap: () => onTapped(deviceList),
        ),
    );
  }

  void onTapped(Device select) {
    // navigate to the next screen.
    LogDebug('Edit name: ${select.name}');
  }
}

class Device {
  String id;
  String name;
  String email;
  String created_at;
  String updated_at;
  Device(this.id, this.name, this.email, this.created_at, this.updated_at);
}


// I/flutter ( 6590): [yru_connect] id = 45671049
// I/flutter ( 6590): [yru_connect] name = F11
// I/flutter ( 6590): [yru_connect] macAddress = 48-83-b4-00-f0-6b