import 'package:flutter/material.dart';
import 'package:yru_flutter_workshop_101/screen/home/tab/tabMe.dart';
import 'package:yru_flutter_workshop_101/screen/home/tab/tabPosts.dart';
import 'package:yru_flutter_workshop_101/screen/home/tab/tabUsers.dart';

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
              TabPosts(), // ignore: missing_required_param
              TabUsers(), // ignore: missing_required_param
              TabMe(), // ignore: missing_required_param
            ],
          ),
        ),
      ),
    );
  }


}

