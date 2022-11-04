import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/screens/auth_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/product_edit_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (context, value, previous) => Products(value.token!,
                value.userId!, previous == null ? [] : previous.items),
            create: (context) => Products(
                Provider.of<Auth>(context, listen: false).token!,
                Provider.of<Auth>(context, listen: false).userId!, []),
          ),
          ChangeNotifierProvider(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, value, previous) =>
                Orders(value.token!,value.userId!, previous == null ? [] : previous.getItems),
            create: (context) =>
                Orders(Provider.of<Auth>(context, listen: false).token!,
                Provider.of<Auth>(context, listen: false).userId!, []),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, value, child) => MaterialApp(
              theme: ThemeData(
                  primarySwatch: Colors.purple,
                  colorScheme: theme.colorScheme.copyWith(
                    secondary: Colors.deepOrange,
                  ),
                  fontFamily: 'Lato'),
              home: value.isAuth ? ProductsOverviewScreen() : AuthScreen(),
              routes: {
                AuthScreen.routeName: (context) => AuthScreen(),
                ProductsOverviewScreen.routeName: (context) =>
                    ProductsOverviewScreen(),
                ProductDetailsScreen.routName: (context) =>
                    const ProductDetailsScreen(),
                CartScreen.routeName: (context) => const CartScreen(),
                OrdersScreen.routeName: (context) => const OrdersScreen(),
                UserProductScreen.routeName: (context) =>
                    const UserProductScreen(),
                ProductEditScreen.routName: (context) =>
                    const ProductEditScreen()
              }),
        ));
  }
}
