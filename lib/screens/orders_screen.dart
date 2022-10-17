import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import '../widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/orders_lists.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = 'orders-screen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const DrawerWidget(),
      body: ListView.builder(
        itemBuilder: (context, index) => OrdersList(
            amount: ordersData.getItems[index].amount,
            orderId: ordersData.getItems[index].id,
            orderItems: ordersData.getItems[index],
            dateTime: ordersData.getItems[index].orderTime),
        itemCount: ordersData.getItems.length,
      ),
    );
  }
}
