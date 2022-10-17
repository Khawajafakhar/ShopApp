import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: 120,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            alignment: Alignment.bottomCenter,
            child: const Text(
              'Drawer!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
           ListTile(
            leading: const Icon(
              Icons.payments,
            ),
            title: const Text(
              'Orders',
            ),
            onTap: (){
              Navigator.of(context).popAndPushNamed(OrdersScreen.routeName);
            },
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.shopping_basket),
            title: const Text(
              'Product',
            ),
            onTap: (){
              Navigator.of(context).popAndPushNamed('/');
            },
          ),
           const Divider(),
           ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Edit Products',
            ),
            onTap: (){
              Navigator.of(context).popAndPushNamed(UserProductScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
