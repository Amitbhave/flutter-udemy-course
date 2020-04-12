import 'package:flutter/material.dart';

class Result extends StatelessWidget{
  final int totalScore;
  final Function resetHandler;

  Result(this.totalScore, this.resetHandler);

  String get resultPhrase{
    return "Total score is: $totalScore";
  }

  String get resetPhrase{
    return "Reset";
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text(resetPhrase),
            onPressed: resetHandler,
          ),
        ]
      )
    );
  }

}