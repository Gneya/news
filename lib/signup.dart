import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:api_test/main.dart';
import 'package:api_test/login.dart';
import 'dart:convert';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
class signup extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<signup> {
  data message;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  var credentials;
  bool _isloading=false;
  var allJson;
  Future<void> _check() async
  {
    setState(() {
      _isloading=true;
    });

    Map d ={
      "email": emailcontroller.text,
      "username": usernameController.text,
      "password": passwordController.text,
      "passwordConf": repasswordController.text,
    };
    if (_formkey.currentState.validate()) {
      var response = await http.post("https://nodejs-register-login-app.herokuapp.com/",body: d);
        message = new data.fromJson(json.decode(response.body.toString()));
        print(allJson);
        if(response.statusCode==200)
          {
            setState(() {
              _isloading=false;
            });
            if(message.str=="You are regestered,You can login now.")
              {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (BuildContext context) => login()), (
                    Route<dynamic> route) => false);
                 Fluttertoast.showToast(msg: message.str,toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 10);
              }
            else
              {
                 Fluttertoast.showToast(msg: message.str,toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 10);
              }
          }
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign up'),
        ),

        body:_isloading ? Center(child: CircularProgressIndicator()): Padding(
            padding: EdgeInsets.all(10),
            child: Form(key:_formkey,child:ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sample',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: usernameController,
                    validator: (val){
                      if(val.isEmpty){
                        return "Username cannot be Empty";}
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailcontroller,
                    validator: (val){
                      if(val.isEmpty){
                        return "Email cannot be Empty";}
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (val){
                    if(val.isEmpty){
                      return "Password cannot be Empty";}
                    return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                    obscureText: true,
                    controller: repasswordController,
                    validator: (val){
                      if(val.isEmpty){
                        return "Retype Password cannot be Empty";}
                      if(passwordController.text!=repasswordController.text)
                        {
                          return "Password and retype password are not same";
                        }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    margin: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Sign up'),
                      onPressed:()=>_check()
                    )),
               ]
            ))));
  }
}
class data
{
      String str;
      data.fromJson(Map<String,dynamic> json)
      {
        this.str=json["Success"];
      }
}