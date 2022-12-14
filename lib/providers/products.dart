import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import '/providers/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

//List<Product> favorite=[];
  List<Product> get items {
    return [..._items];
  }

  final String authToken;
  final String userId;

  Products(this.authToken,this.userId, this._items);

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> favoriteStatus(String id) async {
    var existingProductIndex = _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    existingProduct.toggleFavorites();
    notifyListeners();

    final url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/favouritStatus/$userId/$id.json?auth=$authToken');
    final response = await http.put(url,
        body: json.encode( existingProduct.isFavorite));
    if (response.statusCode >= 400) {
      existingProduct.toggleFavorites();
      _items[existingProductIndex] = existingProduct;
      notifyListeners();
      throw HttpException('Failed to Set Favorite');
    }
  }

  Future<void> fetchAndSetProducts([bool isFiltered=false]) async {
    var filtered= isFiltered ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    var url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filtered');

    try {
      final response = await http.get(url);
      final fetchData = json.decode(response.body) as Map<String, dynamic>;
      print(fetchData);
      url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/favouritStatus/$userId.json?auth=$authToken');
        final favResponse= await http.get(url);
        final favRespDecoded= json.decode(favResponse.body);
        print(favRespDecoded);
      List<Product> fetchedList = [];
      fetchData.forEach((prodkey, prodvalue) {
        fetchedList.add(Product(
          id: prodkey,
          title: prodvalue['title'],
          description: prodvalue['description'],
          imageUrl: prodvalue['imageUrl'],
          price: prodvalue['price'],
          isFavorite:favRespDecoded==null ? false : favRespDecoded[prodkey] ?? false,
        ));
      });
      _items = fetchedList;

      notifyListeners();
    } catch (error) {
      print('errorMessage: $error');
      rethrow;
    }
  }

  Future<void> addProduct(Product newProduct) async {
    var url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    try {
      final response = await http.post(url,
          body: json.encode({
            'id': newProduct.id,
            'imageUrl': newProduct.imageUrl,
            'description': newProduct.description,
            'price': newProduct.price,
            'title': newProduct.title,
            'creatorId' : userId
          }));
          
      _items.insert(
          0,
          Product(
            id: json.decode(response.body)['name'],
            imageUrl: newProduct.imageUrl,
            description: newProduct.description,
            price: newProduct.price,
            title: newProduct.title,
          ));
    } catch (error) {
      print(error);
      rethrow;
    }

    notifyListeners();
  }

  Product selectById(String id) {
    return items.firstWhere((prod) {
      return prod.id == id;
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');
      try{final response=await http.patch(url,
          body: json.encode({
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'title': newProduct.title,
          }));
      _items[productIndex] = newProduct;
    }catch(err){
      print(err);
      rethrow ;
    }
    notifyListeners();
  }}

  Future<void> deleteProduct(String id) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    Product? prod;
    prod = _items[productIndex];
    _items.removeAt(productIndex);
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken');

    final response = await http.delete(url);
    {
      if (response.statusCode >= 400) {
        _items.insert(productIndex, prod);
        notifyListeners();
        throw HttpException('Failed to delete');
      } else {
        prod = null;
      }
    }
  }
}
