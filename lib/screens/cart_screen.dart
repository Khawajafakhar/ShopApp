import 'package:flutter/material.dart';
import 'package:shop_app/providers/orders.dart';
import '../providers/cart.dart' show Cart;
import 'package:provider/provider.dart';
import '../widgets/cart_items.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = 'cart-screen';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Cart',
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Column(
          children: [
            Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Chip(
                          label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                      )),
                       TextButton(
                        onPressed: () {
                          orderData.addOrder(cart.totalAmount, cart.getItems.values.toList());
                          cart.clear();
                        },
                        child: Text('ORDER NOW!'),
                      )
                    ],
                  ),
                )),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => CartItem(
                cart.getItems.keys.toList()[index],
                cart.getItems.values.toList()[index].id,
                cart.getItems.values.toList()[index].price,
                cart.getItems.values.toList()[index].title,
                cart.getItems.values.toList()[index].quantity,
              ),
              itemCount: cart.itemCount,
            ))
          ],
        ));
  }
}
