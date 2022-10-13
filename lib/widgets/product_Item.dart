import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({ Key? key }) : super(key: key);
  String id;
  String imageUrl;
  String title;
  ProductItem(this.id,this.imageUrl, this.title);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        child: Image.network(imageUrl, fit: BoxFit.cover),
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailsScreen.routName,arguments: id);
        },
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: Expanded(
          child: IconButton(
            icon: const Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {},
          ),
        ),
        title: Expanded(
          child: FittedBox(
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        trailing: Expanded(
          child: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
