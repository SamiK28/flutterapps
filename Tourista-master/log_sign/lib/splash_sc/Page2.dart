import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';



class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => new _Page2State();
}

class _Page2State extends State<Page2> {
  Map<DateTime, int> _markedDateMap = {
    DateTime(2018, 12, 12) : 1,
  };

  @override
  Widget build(BuildContext context) {
    return new CalendarCarousel(markedDatesMap: _markedDateMap,);
  }
}
