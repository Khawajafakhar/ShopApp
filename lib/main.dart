import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import './screens/product_details_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MultiProvider(providers: [ChangeNotifierProvider(
      create: (context) => Products(),),
      ChangeNotifierProvider(
      create: (context) => Cart(),)], 
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.purple,
            colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.deepOrange,
            ),
            fontFamily: 'Lato'
            ),
       
        routes: {'/':(context) => ProductsOverviewScreen(),
        ProductDetailsScreen.routName :(context) => const ProductDetailsScreen()}
        
      ),
    );
  }
}
