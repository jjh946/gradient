import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new MyHomePage(title: ''),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}









class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime(2022, 12, 14);
  DateTime _currentDate2 = DateTime(2022, 12, 14);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2022, 12, 14));
  DateTime _targetDateTime = DateTime(2022, 12, 14);
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon

    /// Example Calendar Carousel without header and custom prev & next button
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.green,
      onDayPressed: (date, events) {
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
      },
      daysHaveCircularBorder: true,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.greenAccent,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
//      firstDayOfWeek: 4,

      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
      CircleBorder(side: BorderSide(color: Colors.indigoAccent)),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.blue,
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.yellow,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.tealAccent,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yMMM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('long pressed date $date');
      },
    );

    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ Color(0xffffffff), Color(0xffc8ffeb), Color(0xffbbeaff)]
          ),
        boxShadow:  [

        ],
      ),
      child: new Scaffold(
          backgroundColor: Colors.transparent,

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //custom icon
                 // This trailing comma makes auto-formatting nicer for build methods.
                //custom icon without header

                Container(
                  margin: EdgeInsets.only(
                    top: 30.0,
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      IconButton(
                          onPressed: () {
                            setState(() {
                              _targetDateTime = DateTime(
                                  _targetDateTime.year, _targetDateTime.month + 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          }, icon: const Icon(Icons.arrow_back_ios)
                      ),
                      Expanded(
                          child: Center(
                            child: Text(
                              _currentMonth,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          )),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _targetDateTime = DateTime(
                                _targetDateTime.year, _targetDateTime.month + 1);
                            _currentMonth =
                                DateFormat.yMMM().format(_targetDateTime);
                          });
                        }, icon: const Icon(Icons.arrow_forward_ios)
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _calendarCarouselNoHeader,
                ), //
              ],
            ),
          )),
    );
  }
}