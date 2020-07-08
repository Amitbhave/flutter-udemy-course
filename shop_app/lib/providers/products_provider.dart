import 'dart:convert';
import 'dart:io';

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
    const url = 'https://flutter-shop-app-e3353.firebaseio.com/products.json';
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
    const url = 'https://flutter-shop-app-e3353.firebaseio.com/products.json';
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

  Future<void> updateProduct(String id, Product newProduct) {
    final url = 'https://flutter-shop-app-e3353.firebaseio.com/products/$id.json';
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if(prodIndex >= 0) {
      return patch(
        url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'price': newProduct.price
        })
      ).then((response) {
        _items[prodIndex] = newProduct;
        notifyListeners();
      });
    }
    return Future.value();
  }

  Future<void> deleteProduct(String id) {
    final url = 'https://flutter-shop-app-e3353.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
    return delete(url).then((response) {
      //delete doesn't throw error. you will have to check response code.
      if(response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not delete product.');
      }
      existingProduct = null;
    });
  }

}