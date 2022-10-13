import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import '../widgets/product_grid.dart';
import '../providers/products.dart';

enum selectedOptions{
favorites,
all
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isFav=false;
  @override
  Widget build(BuildContext context) {
    final products=Provider.of<Products>(context);
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
            onSelected: (selectedOptions value){
              setState(() {
                if(value == selectedOptions.favorites){
                  _isFav=true;
              }else{
                 _isFav=false;
              }
              });
              

            },
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductGrid(isFavorite:_isFav),
    );
  }
}
