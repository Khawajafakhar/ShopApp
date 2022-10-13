import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';


class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({ Key? key }) : super(key: key);

  static const routName='product-details-screen';

  @override
  Widget build(BuildContext context) {
    final productId =ModalRoute.of(context)!.settings.arguments as String;
    final productData= Provider.of<Products>(context,listen: false).selectById(productId);
    
    return Scaffold(
      appBar: AppBar(title:  Text(productData.title),backgroundColor: Theme.of(context).primaryColor,),
      body:  Center(child: Text('${productData.id} : ${productData.title}'),),
    );
      
    
  }
}