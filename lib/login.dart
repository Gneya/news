import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:api_test/main.dart';
import 'package:api_test/news.dart';
import 'package:api_test/signup.dart';

class login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<login> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  data message;
  bool _isloading=false;
  _check() async
  {
    setState(() {
      _isloading=true;
    });
    Map d ={
      "email": nameController.text,
      "password": passwordController.text,
    };
      var response = await http.post("https://nodejs-register-login-app.herokuapp.com/login",body:d);
      message=data.fromJson(json.decode(response.body.toString()));
      print(message.toString());
      if(response.statusCode==200) {
        setState(() {
          _isloading=false;
        });
        if (message.success == "This Email Is not regestered!" || message.success=="Wrong password!") {
          Fluttertoast.showToast(msg: message.success,toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 10);
        }
        else
          {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => news()), (
                Route<dynamic> route) => false);
            Fluttertoast.showToast(msg: message.success,toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 10);
          }
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: _isloading?Center(child: CircularProgressIndicator()):Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
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
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    margin: EdgeInsets.only(top:20),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () => _check(),
                    )),
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Does not have account?'),
                        FlatButton(
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20,color: Colors.blue),
                          ),
                          onPressed: () {
                           setState(() {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                           });
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }
}
class data
{
  String success;
  data.fromJson(Map<String,dynamic> json)
  {
    this.success=json["Success"];
  }
}