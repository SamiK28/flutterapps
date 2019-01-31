import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './ui/mainui.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class Front extends StatefulWidget {
  @override
  _FrontState createState() => _FrontState();
}

class _FrontState extends State<Front> {
  bool _check=false;
  String _name;
  @override
  Widget build(BuildContext context) {
    return new Container(
          alignment: Alignment.center,
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                child: Image.asset('images/d1.png',height: 73.0,width: 73.0,color: Colors.white,),
                radius: 70,
                ),
              
              


              _check? welcome(_name):gbutton(),
            ],
          ),             
        );
     
  }

  Future<FirebaseUser> _gSignin() async {
  GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  FirebaseUser user = await _auth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
  setState(() {
   user.displayName.isNotEmpty?_check=true:_check=false;
   _name=user.displayName.toString();
  });

  return user;
}
Widget welcome(String okname){

return Container(
  child:   Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
  
          Container(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text('Welcome $okname',
      
                                  style: Theme.of(context).accentTextTheme.headline,

                      ),
          ),
          Container(
            height: 30.0,
          ),

          Material(
            child: CircleAvatar(
              child: IconButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UI()),
                     );  
                } ,
                icon: Icon(Icons.navigate_next),
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
          ),
    ],
  ),
);

}
Widget gbutton(){
  return new FlatButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),),
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/signin.png',
                    height: 45,
                    width: 220,
                    fit: BoxFit.fill,)
                  ],
                ),
                onPressed: ()=> _gSignin(),
              );

}
}


