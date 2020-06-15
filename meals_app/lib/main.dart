import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_category_data.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/categories.dart';
import 'package:mealsapp/screens/category_meals.dart';
import 'package:mealsapp/screens/filters.dart';
import 'package:mealsapp/screens/meal_detail.dart';
import 'package:mealsapp/screens/tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if(_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if(_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if(_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex = _favouriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0) {
      setState(() {
        _favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavourite(String mealId) {
    return _favouriteMeals.any((meal) => meal.id == mealId);
  }

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
        '/' : (context) => Tabs(_favouriteMeals),
        CategoryMeals.routeName : (context) => CategoryMeals(_availableMeals),
        MealDetails.routeName : (context) => MealDetails(_toggleFavourite, _isMealFavourite),
        Filters.routeName : (context) => Filters(_setFilters, _filters),
      },
    );
  }
}
