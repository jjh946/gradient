import 'package:contact/bizz.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'colorpicker.dart';
import 'circlur_menu.dart';

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

  addGradient(a){
    setState(() {
      gradientList.add(a);
    });
  }

  @override
  Widget build(BuildContext context) {


    return DraggableHome(
      leading: const Icon(Icons.arrow_back_ios),
      title: const Text("Gradient"),
      actions: [
        IconButton(onPressed: () {
          // Within the `FirstRoute` widget
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ColorPickerDemo()),
            );

        }, icon: const Icon(Icons.settings)),
      ],
      headerWidget: headerWidget(context),
      headerBottomBar: headerBottomBarWidget(),
      body: [
        calenderHate()
      ],
      bottomNavigationBar: Builder(
            builder: (context) {
              return FloatingActionButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addApp()),
                  );


                   // return DialogUI( addGradient : addGradient);

                },child: Icon(Icons.add),
              );
            }
            ),

      fullyStretchable: true,
      expandedBody: bizzApp(),
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

  Widget calenderHate(){

    return Container(

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
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: makeGridView4(),
          ),
          //
        ],
      ),
    );
  }

  Widget makeGridView4() {


    return GridView.extent(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        maxCrossAxisExtent: 80.0,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
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
        })
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
class DialogUI extends StatelessWidget {
  DialogUI({Key? key, this.addOne, this.addGradient}) : super(key: key);
  final addOne;
  final addGradient;
  var inputData = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            Text('감정 추가'),
            TextField( controller: inputData, ),
            Text(inputData.text),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){ Navigator.pop(context); }, child: Text("Cancel")),
                TextButton(
                    onPressed: (){
                      addGradient(
                        LinearGradient(colors: [Colors.white, Color(0xffc8ffeb),Colors.blue,],),
                      );
                    },
                    child: Text('OK ')),
              ],
            )
          ],
        ),
      ),
    );;
  }
}

class ColorPallet extends StatelessWidget {
  const ColorPallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
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
