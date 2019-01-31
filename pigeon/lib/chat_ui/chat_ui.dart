import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController _msg=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Name'),
      actions: <Widget>[
        Icon(Icons.more_vert)
      ],
      ),
      body: new Stack(
        children: <Widget>[
            Center(
              child: new Image.asset(
                'images/p1.jpg',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 5.0,left: 6.0),
                  alignment: Alignment.bottomCenter,
                  
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        
                        height: 40.0,
                        width: 290,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          backgroundBlendMode: BlendMode.difference,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: new TextField(),
                      ),
                      Container(
                        width: 7.0,
                      ),
                      
                    ],
                  ),
                ),
                Container(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        width:  50.0,
                        height: 50.0,
                        child: FittedBox(
                          child: FloatingActionButton(
                                  onPressed: null,
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.teal,
                                  child: Icon(Icons.send),
                          ),
                        ),
                      ),
              ],
            )

        

        ],

      ),
    );
  }
}