import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_gradients/flutter_gradients.dart';
import 'colorpicker.dart';
import 'calender.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: "Draggable Home",
    home: HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> {
  DateTime _currentDate = DateTime(2022, 12, 14);
  DateTime _currentDate2 = DateTime(2022, 12, 14);
  String _currentMonth = DateFormat.yMMM().format(DateTime(2022, 12, 14));
  DateTime _targetDateTime = DateTime(2022, 12, 14);

  @override
  Widget build(BuildContext context) {

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




    return DraggableHome(
      leading: const Icon(Icons.arrow_back_ios),
      title: const Text("Gradient"),
      actions: [
        IconButton(onPressed: () {
          // Within the `FirstRoute` widget
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ColorPallet()),
            );

        }, icon: const Icon(Icons.settings)),
      ],
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      body: [
        Container(

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
                                _targetDateTime.year, _targetDateTime.month - 1);
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
                              fontSize: 40.0,
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
        ),

      ],
      fullyStretchable: true,
      expandedBody: Column(),
      backgroundColor: Colors.white,
      appBarColor: Colors.teal,
    );
  }

  Row headerBottomBarWidget() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.green,
            ],
          )
      ),
      child: Center(
        child: Text(
          "Hello Gradient!",
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white70),
        ),
      ),
    );
  }


  ListView listView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (context, index) => Card(
        color: Colors.white70,
        child: ListTile(
          leading: CircleAvatar(
            child: Text("$index"),
          ),
          title: const Text("Title"),
          subtitle: const Text("Subtitile"),
        ),
      ),
    );
  }
}

class ColorPallet extends StatelessWidget {
  const ColorPallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),

        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
