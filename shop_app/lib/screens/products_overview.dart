import 'package:flutter/material.dart';
import 'file:///D:/FlutterCourse/projects/shop_app/lib/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/cart_details.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductOverview extends StatefulWidget {

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {

  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              toggleFavorites(selectedValue);
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) => Badge(
              child: ch,
              value: cartData.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartDetails.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }

  void toggleFavorites(FilterOptions selectedValue) {
    setState(() {
      if(selectedValue == FilterOptions.Favorites) {
        _showOnlyFavorites = true;
      } else {
        _showOnlyFavorites = false;
      }
    });
  }
}
