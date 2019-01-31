import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data/places_data.dart';



class PlaceCardWidget extends StatefulWidget {
  //final PlaceDetail placeDetail;
  final DocumentSnapshot post;
  PlaceCardWidget({this.post});
  @override
  _PlaceCardWidgetState createState() => _PlaceCardWidgetState();
}

class _PlaceCardWidgetState extends State<PlaceCardWidget> {



  final DocumentReference documentReference = Firestore.instance.document("user/pTq8Tl2KuWgYEpblue6453LgCpm1");
  void _add(place, url, desc) {
    Map<String, String> data = <String, String>{
      "place_Name": place,
      "url_dest": url,
      "desc": desc,
    };
    documentReference.setData(data).whenComplete(() {
      print("Document Added");
    }).catchError((e) => print(e));
  }



  @override
  Widget build(BuildContext context) {
    String imgPath = widget.post.data["url"];
    return Scaffold(
        appBar: AppBar(title:widget.post.data["placeName"]!=null?new Text(widget.post.data["placeName"]):new Text("Hello"),),
        body:new Column(
          children:<Widget>[
            new Container(
            child: Card(
                child: ListTile(
                  title:widget.post.data["placeName"]!=null?new Text(widget.post.data["placeName"]):new Text("Hello"),
                  subtitle:widget.post.data["content"]!=null?new Text(widget.post.data["content"]):new Text("Hello"),
                ),
               ),
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
            new Builder(
                  builder: (context) =>new RaisedButton(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    onPressed: (){
                      _add(widget.post.data["placeName"], widget.post.data["url"], widget.post.data["content"]);
                      final snackBar = SnackBar(
                        content: Text('Applied Successfully'),
                        backgroundColor: Colors.green,
                      );
                      // Find the Scaffold in the Widget tree and use it to show a SnackBar!
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    color: Colors.blue,
                    //splashColor: Colors.lightBlueAccent,
                    child: Text('Apply',
                      style: TextStyle(color: Colors.white),),
                ),
              )
            ]
          )
        );
       }
}


