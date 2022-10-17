import 'package:flutter/material.dart';
import 'package:shop_app/widgets/user_product_widgets.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/product_edit_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = 'user-products';

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: (){
                Navigator.of(context).pushNamed(ProductEditScreen.routName);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return UserProductWidget(
              imageUrl: productData.items[index].imageUrl,
              title: productData.items[index].title,
            );
          },
          itemCount: productData.items.length,
        ));
  }
}
