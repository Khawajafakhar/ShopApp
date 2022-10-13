import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import '/widgets/product_Item.dart';

class ProductGrid extends StatelessWidget {
  bool? isFavorite;
   ProductGrid({
    Key? key,
    this.isFavorite
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = isFavorite! ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(
           // products[index].id, 
           // products[index].imageUrl,
           // products[index].title
            ),
        );
      },
      itemCount: products.length,
    );
  }
}
