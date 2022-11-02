import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/drawer_widget.dart';
import '/screens/cart_screen.dart';
import '/widgets/badge%20(1).dart';
import '../widgets/product_grid.dart';
import '../providers/products.dart';
import '../providers/cart.dart';

enum selectedOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);
    static const routeName='product-overview-screen';
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isFav = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    // setState(() {
    //   _isLoading = true;
    // });

    if (_isLoading) {
      Provider.of<Products>(context)
          .fetchAndSetProducts()
          .then((_) => setState(() {
                _isLoading = false;
              }));
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context, listen: false);
    // final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Products'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton(
              itemBuilder: (ctx) {
                return [
                  const PopupMenuItem(
                    child: Text('Favorite Items'),
                    value: selectedOptions.favorites,
                  ),
                  const PopupMenuItem(
                    child: Text('All Items'),
                    value: selectedOptions.all,
                  )
                ];
              },
              onSelected: (selectedOptions value) {
                setState(() {
                  if (value == selectedOptions.favorites) {
                    _isFav = true;
                  } else {
                    _isFav = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
            ),
            Consumer<Cart>(
              builder: (context, value, ch) => Badge(
                child: ch,
                value: value.itemCount.toString(),
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            )
          ]),
      drawer: DrawerWidget(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(isFavorite: _isFav),
    );
  }
}
