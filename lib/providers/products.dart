import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import './product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

//List<Product> favorite=[];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) async {
    final url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/products');
  try {final response=await http
        .post(url,
            body: json.encode({
              'id': newProduct.id,
              'imageUrl': newProduct.imageUrl,
              'description': newProduct.description,
              'price': newProduct.price,
              'title': newProduct.title
            }));
               print(json.decode(response.body));
      _items.insert(
          0,
          Product(
            id: json.decode(response.body)['name'],
            imageUrl: newProduct.imageUrl,
            description: newProduct.description,
            price: newProduct.price,
            title: newProduct.title,
          ));}catch(error){
              print(error);
              rethrow ;
            }
         
      notifyListeners();
    
  }

  Product selectById(String id) {
    return items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((element) => element.id == id);
    _items[productIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
