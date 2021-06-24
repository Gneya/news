import 'dart:async';

import 'package:api_test/login.dart';
import 'package:api_test/news.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_test/signup.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: sfwidget(),
        ),
      ),
    );
  }
}

class sfwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return firstdemo();
  }
}
class firstdemo extends State<sfwidget> {
check(){
  setState(() {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => login()), (
        Route<dynamic> route) => false);
  });

}

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0)).then((value) {
      check();
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("Welcome");
  }
}