import 'package:flutter/material.dart';

import 'colorpicker.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter_gradients/flutter_gradients.dart';
import 'circlur_menu.dart';

void main() {
  runApp(MaterialApp(home: homeApp()));
}



class homeApp extends StatefulWidget {
  @override
  _homeAppState createState() => _homeAppState();
}

class _homeAppState extends State<homeApp> {
  String _colorName = 'No';
  Color _color = Colors.black;

  String _currentMonth = DateFormat.yMMM().format(DateTime(2022, 12, 14));
  DateTime _targetDateTime = DateTime(2022, 12, 14);

  List gradientList = [
    FlutterGradients.magicLake(),
    FlutterGradients.flyingLemon(),
    FlutterGradients.forestInei(),
    FlutterGradients.freshMilk(),
    FlutterGradients.freshOasis(),
    FlutterGradients.frozenBerry(),
    FlutterGradients.frozenDreams(),
    FlutterGradients.frozenHeat(),
    FlutterGradients.fruitBlend(),
    FlutterGradients.gagarinView(),
    FlutterGradients.gentleCare(),
    FlutterGradients.grassShampoo(),
    LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.blue,
        Colors.green,
        Colors.white,
      ],
    ),
  ];

  addGradient(a) {
    setState(() {
      gradientList.add(a);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffffffff),
                Color(0xffffffff),
                Color(0xffc8ffeb),
                Color(0xffbbeaff)
              ]),
          boxShadow: [],
        ),
        child: Scaffold(
              backgroundColor: Colors.transparent,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Builder(
                  builder: (context) {
                    return FloatingActionButton(
                      onPressed: (){
                        _navigateAndDisplaySelection(context);
                      },
                      elevation: 0,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white54,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Icon(Icons.add, size: 40,),

                      ),
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xff606060),
                      hoverColor: Colors.redAccent,
                    );
                  }
              ),
              appBar: AppBar(
                centerTitle: true,
                leading: IconButton(
                    onPressed: () {
                      print('static hahaha');
                    },
                    icon: const Icon(
                      Icons.bar_chart,
                      color: Color(0xff606060),
                    )),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text('Flutter Circular Menu'),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Color(0xff606060),
                      ),
                      onPressed: () {
                        addGradient(
                          LinearGradient(colors: [Colors.white, Color(0xffc8ffeb),Colors.blue,],),
                        );
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.share_outlined,
                        color: Color(0xff606060),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addApp()),
                        );
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.palette_outlined,
                        color: Color(0xff606060),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ColorPickerDemo()),
                        );
                      }),
                ],
              ),
              body:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    shitcalendar(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: makeGridView4(),
                    ),
                  ]
              )

          )
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => addApp()),
    ).then((value){
      addGradient(value);
    });

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }

  Widget shitcalendar() {
    return Container(
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
                  _targetDateTime =
                      DateTime(_targetDateTime.year, _targetDateTime.month - 1);
                  _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                });
              },
              icon: const Icon(Icons.arrow_back_ios)),
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
                  _targetDateTime =
                      DateTime(_targetDateTime.year, _targetDateTime.month + 1);
                  _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                });
              },
              icon: const Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );

    //
  }

  Widget makeGridView4() {
    return GridView.extent(
        //scrollDirection: Axis.vertical,
        shrinkWrap: true,
        maxCrossAxisExtent: 80.0,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.2,
        children: List.generate(gradientList.length, (index) {
          return Expanded(
            child: Container(
              width: 50,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: gradientList[index],
              ),
            ),
          );
        }));
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context, 'Yep!');
                },
                child: const Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Close the screen and return "Nope." as the result.
                  Navigator.pop(context, 'Nope.');
                },
                child: const Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}