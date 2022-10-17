import 'dart:math';

import 'package:flutter/material.dart';

class CartItem {
  String? id;
  String? title;
  double? price;
  double? quantity;

  CartItem(
      {@required this.id,
      @required this.title,
      @required this.price,
      @required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get getItems {
    return _items;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    return total;
  }

  void addItems(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      // ... updating the existing product
      _items.update(
          productId,
          (existingValue) => CartItem(
              id: existingValue.id,
              title: existingValue.title,
              price: existingValue.price,
              quantity: existingValue.quantity! + 1));
    } else {
      //...adding a new cartItem
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    } else if (_items[id]!.quantity! > 1) {
    _items.update(
          id,
          (existingvalue) => CartItem(
                id: existingvalue.id,
                title: existingvalue.title,
                price: existingvalue.price,
                quantity: existingvalue.quantity! - 1,
              ));
              
    }else{
       _items.remove(id);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
