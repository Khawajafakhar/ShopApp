import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  //const ProductItem({ Key? key }) : super(key: key);
  String imageUrl;
 ProductItem(this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return GridTile(child: Image.network(imageUrl,fit: BoxFit.cover));
      
    
  }
}