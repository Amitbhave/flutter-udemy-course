import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shopapp/providers/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> addProduct(Product product) {
    const url = 'your_url';
    return post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavorite': product.isFavourite,
      }),
    ).then((response) {
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> fetchProducts() {
    const url = 'your_url';
    return get(url)
        .catchError((error) {
          print(error);
          throw error;
        })
        .then((response) {
          final extractedData = json.decode(response.body) as Map<String, dynamic>;
          final List<Product> loadedProducts = [];
          extractedData.forEach((productId, productData) {
            loadedProducts.add(Product(
              id: productId,
              title: productData['title'],
              price: productData['price'],
              description: productData['description'],
              imageUrl: productData['imageUrl'],
              isFavourite: productData['isFavorite'],
            ));
          });
          _items = loadedProducts;
          notifyListeners();
        });
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }

}