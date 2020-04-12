import 'package:flutter/material.dart';

import 'package:quizapp/quiz.dart';
import 'package:quizapp/result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _totalScore = 0;
  var _questionIndex = 0;
  var _questions = [
    {
      "questionText": "What's your name?",
      "answers": [
        {"text" : "Virat", "score" : 10},
        {"text" : "Rohit", "score" : 6},
        {"text" : "Yuvraj", "score" : 8},
        {"text" : "Dhoni", "score" : 9}
      ]
    },
    {
      "questionText": "What's your favorite animal?",
      "answers": [
        {"text" : "Elephant", "score" : 10},
        {"text" : "Snake", "score" : 0},
        {"text" : "Rabbit", "score" : 5},
        {"text" : "Tiger", "score" : 9}
      ]
    },
    {
      "questionText": "What's your favorite color?",
      "answers": [
        {"text" : "Red", "score" : 5},
        {"text" : "Blue", "score" : 5},
        {"text" : "Green", "score" : 2},
        {"text" : "Yellow", "score" : 3}
      ]
    },
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
          title: Text("Quiz App"),
        ),
        body: (_questionIndex < _questions.length)
            ? Quiz(_questions, _questionIndex, _answerQuestion)
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }

  void _answerQuestion(int score){
    _totalScore += score;
    setState(() {
        _questionIndex = _questionIndex + 1;
    });
    print("Answered..!");
  }

  void _resetQuiz(){
    _totalScore = 0;
    setState(() {
      _questionIndex = 0;
    });
  }

}
