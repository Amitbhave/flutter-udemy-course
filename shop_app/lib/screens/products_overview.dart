import 'package:flutter/material.dart';
import 'file:///D:/FlutterCourse/projects/shop_app/lib/widgets/products_grid.dart';

class ProductOverview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
