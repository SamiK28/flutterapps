import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

final FirebaseDatabase database=FirebaseDatabase.instance;

class Get{

  String username,phoneno,photourl,emailid;
  Get(this.username,this.phoneno,this.emailid,this.photourl);

  Get.fromSnapshot(DataSnapshot snapshot):
  username=snapshot.value["username"],
  phoneno=snapshot.value["phoneno"],
  emailid=snapshot.value["emailid"],
  photourl=snapshot.value["photourl"];
  
}

class Getdata extends StatefulWidget {
  @override
  _GetdataState createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
@override
  void initState(){
    super.initState();
    setState(() {
     database.reference().child("cerrent_user").once().then((DataSnapshot snapshot){
       Map<dynamic,dynamic> data = snapshot.value;
       Get(data["username"].toString(), data["phoneno"].toString(), data["emailid"].toString(), data["photourl"].toString());
     });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}








