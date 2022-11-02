import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import '../widgets/drawer_widget.dart';
import 'package:provider/provider.dart';
import '../widgets/orders_lists.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = 'orders-screen';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future _ordersFuture;

  Future<void> _getOrdersData() {
   return  Provider.of<Orders>(context, listen: false).fetchAndSet();
  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture = _getOrdersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: const DrawerWidget(),
        body: FutureBuilder(future: _ordersFuture,builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Text('Error Occured');
            } else {
              return ListView.builder(
                itemBuilder: (context, index) => OrdersList(
                    amount: ordersData.getItems[index].amount,
                    orderId: ordersData.getItems[index].id,
                    orderItems: ordersData.getItems[index],
                    dateTime: ordersData.getItems[index].orderTime),
                itemCount: ordersData.getItems.length,
              );
            }
          }
        })));
  }
}
