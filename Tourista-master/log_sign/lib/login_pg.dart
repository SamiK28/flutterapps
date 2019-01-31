import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn; //VoidCallback takes no parameters and returns no parameters

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

enum FormType{
  login,
  register
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin{
  static const numBehaviours = 6;


  ParticleOptions particleOptions = ParticleOptions(
    baseColor: Colors.lightGreenAccent,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.2,
    maxOpacity: 0.4,
    spawnMinSpeed: 30.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 7.0,
    spawnMaxRadius: 15.0,
    particleCount: 45,
  );

  var particlePaint = Paint()
    ..style = PaintingStyle.fill
    ..strokeWidth = 1.0;




  // General Variables
  int _behaviourIndex = 0;
  Behaviour _behaviour;


  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void validateAndSubmit() async{
    if(validateAndSave()){
      print('Validate and Save');
      try {
        if(_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password); //asynchronous and returns a firebase user
          print('Signed in: $userId');
        }
        else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email , _password);
          print('Registered User: $userId');
        }
        widget.onSignedIn();
      }
      catch(e){
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Material(
        child: new InkWell(
          onTap: (){},
          child: AnimatedBackground(
            behaviour: _behaviour = _buildBehaviour(),
            vsync: this,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0,100.0,20.0,0.0),
              child: new Form(
                key: formKey,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs()+buildSubmitButtons(),
                )
              ),
            ),
          )
        )
      ),
    );
  }



  List<Widget> buildInputs(){
    return[
    new IconButton(
      // Use the FontAwesomeIcons class for the IconData
        icon: new Icon(FontAwesomeIcons.hotel , size: 100.0 , color:const Color(0xff7c94b6)),  //0xff7c94b6  0xFFA67563  0xff4d342a
    ),
      new SizedBox(height: 100.0),
      new TextFormField(
        decoration: new InputDecoration(labelText:'Email',contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty': null,
        onSaved: (value) => _email = value,

      ),
      new SizedBox(height: 8.0),
      new TextFormField(
        decoration: new InputDecoration(labelText:'Password',contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty': null,
        onSaved: (value) => _password = value,
        obscureText: true,
      ),
    ];
  }

  List<Widget> buildSubmitButtons(){
    if(_formType == FormType.login){
      return[
        new SizedBox(height: 15.0),
        new RaisedButton(
          child: new Text('Log In', style: new TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Nunito')),
          onPressed: validateAndSubmit,
          color: Colors.lightBlueAccent,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
        new RaisedButton(
            onPressed: moveToRegister,
            child: new Text('Create an account',style: new TextStyle(fontSize:20.0, color: Colors.white, fontFamily: 'Nunito')),
            color: Colors.lightBlueAccent,
            shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        )
      ];
    }
   else{
      return[
        new SizedBox(height: 15.0),
        new RaisedButton(
          child: new Text('Create an account', style: new TextStyle(fontSize: 20.0, color: Colors.white,fontFamily: 'Nunito'), ),
          onPressed: validateAndSubmit,
          color: Colors.lightBlueAccent,
        ),
        new RaisedButton(
            onPressed: moveToLogin,
            child: new Text('Have an account? Log In',style: new TextStyle(fontSize:20.0, color: Colors.white,fontFamily: 'Nunito')),
            color: Colors.lightBlueAccent,
        )
      ];
    }
  }


  Behaviour _buildBehaviour() {
    return RandomParticleBehaviour(
      options: particleOptions,
      paint: particlePaint,
    );
  }


}

enum ParticleType {
  Shape,
  Image,
}