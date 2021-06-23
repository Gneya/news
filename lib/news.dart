import 'dart:convert';
import 'main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() => runApp(news());

class news extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  sfwidget(),
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
  var _data=List<data>();
  bool _isloading=false;
  List<data> forui=List<data>();
  var selectedindex;
  List<data> _saved=List<data>();
  bool _color=false;
   Future<List<data>>_get() async{
     setState(() {
       _isloading=true;
     });
    var response= await http.get("https://api.first.org/data/v1/news");
    if(response.statusCode==200)
    {
      var allJson=json.decode(response.body)["data"];
      for(var d in allJson) {
        _data.add(data.fromJson(d));
      }
      setState(() {
        _isloading=false;
      });
      return _data;
    }
  }
  @override
  void initState() {
    _get().then((value)
    {
      setState(() {
        forui.addAll(value);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      appBar: AppBar(
        title: Text('Flutter Tabs Demo'),
        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.contacts), text: "news"),
            Tab(icon: Icon(Icons.camera_alt), text: " Favs")
          ],
        ),
      ),
      body:_isloading ? Center(child: CircularProgressIndicator()):
          TabBarView(children: [
      ListView.builder(
      itemCount: forui.length,
           itemBuilder: (context,index)
            {
              return Card(child:Column(children:
              [Row(children:[GestureDetector(child:Icon(Icons.favorite,color: selectedindex==index?Colors.red:null,),
                onTap: (){
                  setState(() {
                    selectedindex=index;
                  });
                  if(!_saved.contains(_data[index]))
                  _saved.add(_data[index]);
                  _data.remove(_data[index]);
                  selectedindex=null;
                  },
              )
              ]),
                Column(
                  children: [
                   Text(_data[index].title,style: TextStyle(fontSize: 20),),
                    Text(_data[index].published,style: TextStyle(fontSize: 6,color: Colors.grey),),
                  ],
                ),])
              );
            },
          ),
            ListView.builder(
              itemCount: _saved.length,
              itemBuilder: (context,index)
              {
                return Card(child:Column(children:
                [Row(children:[GestureDetector(child:Icon(Icons.favorite,color:Colors.red),
                  onTap: (){setState(() {
                    _data.add(_saved[index]);
                    _saved.remove(_saved[index]);
                  });},
                )
                ]),
                  Column(
                    children: [
                      Text(_saved[index].title,style: TextStyle(fontSize: 20),),
                      Text(_saved[index].summary, style: TextStyle(fontSize: 10),),
                      Text(_saved[index].published,style: TextStyle(fontSize: 6,color: Colors.grey),),
                    ],
                  ),])
                );
              },
            ),

      ]
          )
    ));
  }
}
class data {
  String title;
  String summary;
  String published;
  data.fromJson(Map<String,dynamic>json)
  {
    this.title=json["title"];
    this.summary=json["summary"];
    this.published=json["published"];
  }
}