import 'package:flutter/material.dart';
import 'auth.dart';
import 'welcome_pg.dart';
import 'login_pg.dart';
import 'root_page.dart';

int temp=0;

class HomePage extends StatelessWidget{
  HomePage({this.auth , this.onSignedOut});
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
  Widget build(BuildContext context) {

    return new WelPage(auth: this.auth , onSignedOut: this.onSignedOut);

  }
}


