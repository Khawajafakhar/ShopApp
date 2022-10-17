import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/cart.dart';
import 'dart:math';
import '../providers/orders.dart' as ord;

class OrdersList extends StatefulWidget {
  final amount;
  final orderId;
  final ord.OrderItems? orderItems;
  final DateTime? dateTime;

  OrdersList({
    @required this.amount,
    @required this.orderId,
    @required this.orderItems,
    @required this.dateTime,
  });

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  bool isdrop = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: CircleAvatar(
          radius: 35,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text('\$${widget.amount}'),
            ),
          ),
        ),
        title: FittedBox(child: Text('Order ID : ${widget.orderId!}')),
        subtitle: Text(
          DateFormat('yyyy-MM-dd').format(widget.dateTime!).toString(),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              isdrop = !isdrop;
            });
          },
          icon: isdrop
              ? const Icon(Icons.arrow_drop_down)
              : const Icon(Icons.arrow_drop_up),
        ),
      ),
      if(isdrop)
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: (widget.orderItems!.orderList!.length * 10.0 + 50),
        child: ListView(
          children: [
            ...widget.orderItems!.orderList!.map((e) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(e.title!),Text('\$${e.price} X ${e.quantity}')],
                ))
          ],
        ),
      ),
    ]);
  }
}
