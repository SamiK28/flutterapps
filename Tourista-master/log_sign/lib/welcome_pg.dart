import 'package:flutter/material.dart';
import 'auth.dart';
import 'splash_sc/Page0.dart';
import 'splash_sc/Page1.dart';
import 'splash_sc/Page2.dart';
import 'login_pg.dart';
import'home_pg.dart';



PageController pageControl;


class WelPage extends StatefulWidget {

  WelPage({this.auth , this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async{
    try{
      await auth.signOut();
      onSignedOut();
    }
    catch(e){
      print(e);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return new _WelPageState();
  }
}

class _WelPageState extends State<WelPage> {
  int page = 0;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text('Tourista'), centerTitle: true,
            actions: <Widget>[
              new FlatButton(
                  onPressed: widget._signOut,
                  child: new Text('Log Out',style: new TextStyle(fontSize: 17.0, color: Colors.white))
              ),
            ]
        ),
        body: new PageView(children: [
          new Page0(),
          new Page1(),
          new Page2(),
        ], controller: pageControl, onPageChanged: onPageChange),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          /*new BottomNavigationBarItem(
              icon: new Icon(Icons.desktop_mac),
              title: new Text('Company\nProjects'),
            ),*/
          new BottomNavigationBarItem(
            icon: new Icon(Icons.account_balance),
            title: new Text('Availaible\nPlaces'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.check),
            title: new Text('Your\nDestinations'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile')
          )
        ],
        onTap: navTapped,
        currentIndex: page,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pageControl = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageControl.dispose();
  }

  void onPageChange(int page) {
    setState(() {
      this.page = page;
    });
  }

  void navTapped(int page) {
    pageControl.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }
}