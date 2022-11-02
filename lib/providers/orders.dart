import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> fetchAndSet() async {
    final url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/orders.json');
   try {final response = await http.get(url);
    if(response.statusCode>=400){
      return;
    }
    List<OrderItems> fetchedList = [];
    final decodedResponse = json.decode(response.body) as Map<String, dynamic>;
    decodedResponse.forEach((orderId, orderValue) {
      fetchedList.add(OrderItems(
          id: orderId,
          amount: double.parse(orderValue['amount'].toString()) ,
          orderTime: DateTime.parse(orderValue['orderTime']),
          orderList: (orderValue['orderList'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  price:  e['price'],
                  quantity: e['quantity']))
              .toList()));
    });
        _items=fetchedList;
}catch(error){
  print(error);
}
    notifyListeners();
  }

  Future<void> addOrder(
    double total,
    List<CartItem> orderList,
  ) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://flutter-update-7ebbf-default-rtdb.firebaseio.com/orders.json');
    final response = await http.post(url,
        body: json.encode({
          'amount': total.toStringAsFixed(2),
          'orderTime': timeStamp.toIso8601String(),
          'orderList': orderList
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'price': e.price,
                    'quantity': e.quantity,
                  })
              .toList()
        }));
    if (response.statusCode >= 400) {
      print('Orders Not added');
    }

    _items.insert(
        0,
        OrderItems(
          id: json.decode(response.body)['name'],
          amount: total,
          orderTime: timeStamp,
          orderList: orderList,
        ));
    notifyListeners();
  }
}
