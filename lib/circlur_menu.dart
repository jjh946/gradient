import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';

void main() {
  runApp(addApp());
}

class addApp extends StatefulWidget {
  @override
  _addAppState createState() => _addAppState();
}

class _addAppState extends State<addApp> {
  String _colorName = 'No';
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: Color(0xffEEDFE4FF),
          title: Text('Flutter Circular Menu'),
        ),
        body: CircularMenu(
          alignment: Alignment.bottomCenter,
          backgroundWidget: Center(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 28),
                children: <TextSpan>[
                  TextSpan(
                    text: _colorName,
                    style:
                    TextStyle(color: _color, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' button is clicked.'),
                ],
              ),
            ),
          ),
          toggleButtonColor: Colors.blue,
          items: [
            CircularMenuItem(

                color: Color(0xffE8F8C8),
                onTap: () {
                  setState(() {
                    _color = Color(0xffE8F8C8);
                    _colorName = '뿌듯';
                  });
                }),
            CircularMenuItem(

                color: Color(0xff78BFE8),
                onTap: () {
                  setState(() {
                    _color = Color(0xff78BFE8);
                    _colorName = '슬픔';
                  });
                }),
            CircularMenuItem(

                color: Color(0xffECACB8),
                onTap: () {
                  setState(() {
                    _color = Color(0xffECACB8);
                    _colorName = '기쁨';
                  });
                }),
            CircularMenuItem(

                color: Color(0xffCBD2FD),
                onTap: () {
                  setState(() {
                    _color = Color(0xffCBD2FD);
                    _colorName = '피곤';
                  });
                }),
            CircularMenuItem(

                color: Color(0xff9ED6C0),
                onTap: () {
                  setState(() {
                    _color = Color(0xff9ED6C0);
                    _colorName = '아쉬움';
                  });
                })
          ],
        ),
      ),
    );
  }
}