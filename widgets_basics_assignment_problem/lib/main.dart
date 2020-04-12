import 'package:flutter/material.dart';
import 'package:flutter_course/text.dart';
import 'package:flutter_course/text_control.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _textIndex = 0;
  var _texts = [
    "This is my text one",
    "This is my text two",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Assignment one"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(_texts[_textIndex]),
            TextControl(changeText)
          ],
        ),
      ),
    );
  }
  void changeText(){
    if(_textIndex < _texts.length - 1){
      setState(() {
        _textIndex += 1;
      });
    } else{
      setState(() {
        _textIndex = 0;
      });
    }
  }

}