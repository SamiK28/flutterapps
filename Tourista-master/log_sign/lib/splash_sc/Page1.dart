import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => new _Page1State();
}

class _Page1State extends State<Page1> {
  String imgPath;
  String myText;
  String desc;
  StreamSubscription<DocumentSnapshot> subscription;

  final DocumentReference documentReference = Firestore.instance.document("user/pTq8Tl2KuWgYEpblue6453LgCpm1");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          myText = datasnapshot.data['place_Name'];
          imgPath = datasnapshot.data["url_dest"];
          desc = datasnapshot.data["desc"];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        backgroundColor: Colors.green,
        body:new Container(
          //margin: EdgeInsets.only(left: 10.0, right: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child:new Card(
              child: new Container(
                child:new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    new Container(
                      padding:EdgeInsets.only(left: 0.0,top: 10.0),
                      child: Text(myText,style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)
                      ),
                      alignment: Alignment(0.0, 0.0),
                    ),
                    new Container(
                      padding: EdgeInsets.all(10.0),
                      child:new ClipRRect(
                        borderRadius: new BorderRadius.circular(8.0),
                        child:new FadeInImage(placeholder: new AssetImage("assets/map.jpg"),
                            fit: BoxFit.cover,
                            image:new NetworkImage(imgPath)
                        ),
                      ),
                    ),
                    new Container(
                      padding:EdgeInsets.only(left: 0.0,top: 10.0),
                      child: Text(desc,style: TextStyle(color: Colors.grey,)
                    )
                    )
                  ],
                ),
                //alignment: Alignment(0.0, 0.0),
              ),
            )
        )
    );
  }
}


