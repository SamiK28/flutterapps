import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../info/utils.dart' as util;

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  String _cityEntered;

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator
        .of(context)
        .push(new MaterialPageRoute<Map>(builder: (
        BuildContext context) { //change to Map instead of dynamic for this to work
            return new ChangeCity();
        }
    )
        );
    if ( results != null && results.containsKey('enter')) {
      _cityEntered = results['enter'];

//      debugPrint("From First screen" + results['enter'].toString());


    }
  }

    void showStuff() async {
      Map data = await getWeather(util.appId, util.defaultCity);
      print(data.toString());
    }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(icon: new Icon(Icons.menu), onPressed: null),
          title: new Text('My Weather App',),
          centerTitle: true,
          backgroundColor: Colors.green.shade700,
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: () {
            _goToNextScreen(context);
          },
          backgroundColor: Colors.green.shade700,
          tooltip: 'add city',
          child: new Icon(Icons.add),
        ),
        body: new Stack(
          children: <Widget>[
            new Center(
              child: new Image.asset(
                'images/umbrella.png',
                width: 490.0,
                height: 1200.0,
                fit: BoxFit.fill,
              ),
            ),
            new Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
              child: new Text(
                '${_cityEntered == null ? util.defaultCity : _cityEntered}',
                style: cityStyle(),

              ),
            ),

            new Container(
              alignment: Alignment.center,
              child: new Image.asset('images/light_rain.png'),
            ),
            updateTempWidget(_cityEntered)

          ],
        ),
      );
    }
  }


  Future<Map> getWeather(String appId, String city) async {
    String apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid='
        '${util.appId}&units=metric';

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Widget updateTempWidget(String city) {
    return new FutureBuilder(
        future: getWeather(util.appId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          //where we get all of the json data, we setup widgets etc.
          if (snapshot.hasData) {
            Map content = snapshot.data;
            return new Container(
              margin: const EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      content['main']['temp'].toString() + " °C",
                      style: new TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 49.9,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: new ListTile(
                      title: new Text(
                        "Humidity: ${content['main']['humidity'].toString()}\n"
                            "Min: ${content['main']['temp_min']
                            .toString()} °C\n"
                            "Max: ${content['main']['temp_max']
                            .toString()} °C ",

                        style: extraData(),

                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return new Container();
          }
        });
  }
class ChangeCity extends StatelessWidget {

  var _cityFieldController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green.shade700,
        title: new Text('Change City'),
        centerTitle: true,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/white_snow.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),

          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'Enter City',
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),

              ),
              new Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(left: 70.0,right: 70.0),
                child: new FlatButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        'enter': _cityFieldController.text
                      });
                    },
                    textColor: Colors.white,
                    color: Colors.green.shade700,
                    child: new Text('Get Weather')),
              )
            ],
          )
        ],
      ),
    );
  }
}
  TextStyle extraData() {
    return new TextStyle(
        color: Colors.white70,
        fontStyle: FontStyle.normal,
        fontSize: 17.0);
  }

  TextStyle cityStyle() {
    return new TextStyle(
        color: Colors.white, fontSize: 22.9, fontStyle: FontStyle.italic,

    );
  }