import 'package:flutter/material.dart';

class CenterPage extends StatefulWidget {

  final String title;

  const CenterPage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CenterPageState();
  }
}

class _CenterPageState extends State<CenterPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
        // title: Text(widget.title),
      // ),
      body: new Container(
          color: Colors.white,
          padding: new EdgeInsets.all(16.0),
          child: Center(
            child: Text(
                '${widget.title}',
                style: TextStyle(fontSize: 30,color: Colors.black)
            ),

            // child: Container(
            //   width: 150.0,
            //   height: 100.0,
            //   color: Colors.red,
            // ),
            //
            // child: Image.asset('assets/images/logo/splash_yru_logo.png',
            //   height: 250.0,
            // ),


          ),
      ),
    );
  }


}

