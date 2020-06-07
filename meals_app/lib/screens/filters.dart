import 'package:flutter/material.dart';
import 'package:mealsapp/widgets/drawer.dart';

class Filters extends StatelessWidget {
  static const routeName = '/filters';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Filters screen'),
      ),
    );
  }

}