import 'package:flutter/material.dart';
import 'login_pg.dart';
import 'auth.dart';
import 'root_page.dart';
import 'home_pg.dart';
import 'welcome_pg.dart';
import'places.dart';

//secret: sk.eyJ1IjoidGFzaDE0OSIsImEiOiJjam9mdW96b3YwN3FsM2ttdWhoaGdzZjZ1In0.sPk6_xr99OB8bhgtmB0hxQ
//public: pk.eyJ1IjoidGFzaDE0OSIsImEiOiJjam9mdW5wazAwNjl0M3Ftd2w3NjkwOGs0In0.RbHY8nycZDav-6P5pDPcZA
void main(){
  runApp(new MyApp());
}

class MyApp extends StatelessWidget{
    @override
  Widget build(BuildContext context) {

      return new MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Login',
          theme: new ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: new RootPage(auth: new Auth()),
        routes: <String, WidgetBuilder>{
          '/HomePg': (BuildContext context) => new HomePage(),
          '/WelcomePg': (BuildContext context) => new WelPage(),
          '/LogInPg':(BuildContext context) => new LoginPage(auth: new Auth()),
          },
      );
  }

}

