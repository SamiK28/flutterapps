import 'package:flutter/material.dart';
import 'login_pg.dart';
import 'auth.dart';
import 'home_pg.dart';

class RootPage extends StatefulWidget{
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState()=> new _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage>{

  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState(){
    super.initState();
    widget.auth.currentUser().then((userId){  //could have used await but init State doesn't support async method and await
      setState((){
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
            auth: widget.auth,
            onSignedIn: _signedIn ,
        );
      case AuthStatus.signedIn:
        return new HomePage(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
    return new LoginPage(auth: widget.auth);
  }
}