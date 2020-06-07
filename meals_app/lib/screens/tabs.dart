import 'package:flutter/material.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/favourites.dart';
import 'package:mealsapp/widgets/drawer.dart';

class Tabs extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _TabsState();

}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(

            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favourites',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Categories(),
            Favourites(),
          ],
        ),
      ),
      length: 2,
    );
  }

}