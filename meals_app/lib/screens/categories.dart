import 'package:flutter/material.dart';
import 'package:mealsapp/data/dummy_category_data.dart';
import 'package:mealsapp/widgets/category_item.dart';

class Categories extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliMeals'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        children: DUMMY_CATEGORIES.map((categoryData) =>
            CategoryItem(
              categoryData.id,
              categoryData.title,
              categoryData.color,
            )).toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }

}