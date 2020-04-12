import 'package:flutter/material.dart';

class TextControl extends StatelessWidget{
  final Function changeHandler;

  TextControl(this.changeHandler);

  String get changeTextPhrase{
    return "Change Text";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            children: [
              RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text(changeTextPhrase),
                onPressed: changeHandler,
              ),
            ]
        )
    );
  }

}