import 'package:flutter/material.dart';
import '/providers/cart.dart';

class OrderItems {
  String? id;
  double? amount;
  List<CartItem>? orderList;
  DateTime? orderTime;

  OrderItems({
    @required this.id,
    @required this.amount,
    @required this.orderTime,
    @required this.orderList,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _items = [];

  List<OrderItems> get getItems {
    return [..._items];
  }

  void addOrder(
    double total,
    List<CartItem> orderList,
  ) {
    _items.insert(
        0,
        OrderItems(
          id: DateTime.now().toString(),
          amount: total,
          orderTime: DateTime.now(),
          orderList: orderList,
        ));
        notifyListeners();
  }
}
