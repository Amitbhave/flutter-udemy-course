import 'package:flutter/material.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/category_meals.dart';
import 'package:mealsapp/screens/meal_detail.dart';
import 'package:mealsapp/screens/tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Meals',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1)
            ),
            bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1)
            ),
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold,
          )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => Tabs(),
        CategoryMeals.routeName : (context) => CategoryMeals(),
        MealDetails.routeName : (context) => MealDetails()
      },
    );
  }
}
