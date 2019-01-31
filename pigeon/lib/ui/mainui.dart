import 'package:flutter/material.dart';
import '../chat_ui/chat_ui.dart';

class UI extends StatefulWidget {
  @override
  _UIState createState() => _UIState();
}

class _UIState extends State<UI> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
          length: 2,
          child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.camera)),
                ],
          ),
          title: Text('Pigeon'),
          actions: <Widget>[
            new IconButton(icon: Icon(Icons.search),onPressed: null,),
            new Container(width: 20.0)
         ],
         leading: IconButton(onPressed: null,icon: Icon(Icons.menu),color: Colors.white),
        ),
        body: new TabBarView(
              children: [
                appinterface(),
                Center(child: Text('page 2'),)
              ],
            ),
          ),
    );
  }
}

Widget appinterface(){
 
 return new Stack(
   children: <Widget>[
     Container(
       
       child:  ListView.builder(
         
                      itemCount: 2,
                      
                      itemBuilder: (BuildContext context,int index){
                        return new ListTile(
                          leading: CircleAvatar(backgroundColor: Colors.orangeAccent,),
                          title: Text('Contact Name'),
                          subtitle: Text('Last Message'),
                          onTap: () {
                                        Navigator.push(
                                         context,
                                         MaterialPageRoute(builder: (context) => Chat()),
                                        );
                          },
                        );
                        
                      },
                    ),

     ),
    Container(
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(20.0),
                    child: FloatingActionButton(
                      onPressed: null,
                      backgroundColor: Colors.teal,
                      child: Icon(Icons.message),
                    ),
                  ),
   ],
 );


}
  




