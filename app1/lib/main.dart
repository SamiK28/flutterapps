import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
void main(){
  runApp(MaterialApp(
    title: 'Search',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _query =new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEARCH'),
        centerTitle: true,
      ),
      body: Container(
        width: 200,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
          controller: _query,
          decoration: InputDecoration(
            icon: Icon(Icons.search),
            hintText: 'Google Search',
          ),
        ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            new RaisedButton(onPressed: (){
              _search(_query.text);
            },
            child: Text('Search'),
            ),
          
          ],
        )
      ),
      
    );
  }
}

_search(String query) async
{
  String url = "https://www.google.com/search?q=$query";

  if (await canLaunch(url)) {
    await launch(url);
  }

  else {
    throw 'Could not launch $url';
  }
}

