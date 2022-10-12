import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({ Key? key }) : super(key: key);
  String imageUrl;
    String title;
  ProductItem(this.imageUrl,this.title);
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(imageUrl, fit: BoxFit.cover),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: const IconButton(icon: Icon(Icons.favorite_border),onPressed: null,),
        title: Text(title,textAlign: TextAlign.center,),
        trailing:const IconButton(icon: Icon(Icons.shopping_cart),onPressed: null,),
      ),
    );
  }
}
