import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/widgets/meal_item.dart';

class Favourites extends StatelessWidget {
  final List<Meal> favouriteMeals;

  Favourites(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favourites yet!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity,
            duration: favouriteMeals[index].duration,
          );
        },
        itemCount: favouriteMeals.length,
      );
    }

  }

}