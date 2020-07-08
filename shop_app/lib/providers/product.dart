import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  void _setFavValue(bool newValue) {
    isFavourite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavouriteStatus() {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = 'https://flutter-shop-app-e3353.firebaseio.com/products/$id.json';
    return patch(
        url,
        body: json.encode({
          'isFavorite': isFavourite,
        })
    ).then((response) {
      if(response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    }).catchError((error){
      _setFavValue(oldStatus);
    });
  }

}