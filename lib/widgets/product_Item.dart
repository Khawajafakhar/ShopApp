import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/product_details_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetails = Provider.of<Product>(context, listen: false);
    final cart=Provider.of<Cart>(context,listen: false);
    return Scaffold(
      body: GridTile(
        child: GestureDetector(
          child: Image.network(productDetails.imageUrl, fit: BoxFit.cover),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.routName,
                arguments: productDetails.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
              builder: ((context, value, _) => IconButton(
                    icon: productDetails.isFavorite
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () {
                      productDetails.toggleFavorites();
                    },
                  ))),
          title: FittedBox(
            child: Text(
              productDetails.title,
              textAlign: TextAlign.center,
            ),
          ),
          trailing:  IconButton(
              color: Theme.of(context).colorScheme.secondary,
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                cart.addItems(productDetails.id,productDetails.title,productDetails.price);
              },
            ),
            
          
        ),
      ),
    );
  }
}
