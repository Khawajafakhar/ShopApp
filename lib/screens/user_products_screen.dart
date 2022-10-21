import 'package:flutter/material.dart';
import 'package:shop_app/widgets/user_product_widgets.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../screens/product_edit_screen.dart';

class UserProductScreen extends StatelessWidget {
  const UserProductScreen({Key? key}) : super(key: key);
  static const routeName = 'user-products';

  Future<void> _getrefresh(BuildContext context) async{
   await  Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context,);
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
        body: RefreshIndicator(
          onRefresh: () => _getrefresh(context),
          child: Padding(padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return UserProductWidget(
                  id: productData.items[index].id,
                  imageUrl: productData.items[index].imageUrl,
                  title: productData.items[index].title,
                );
              },
              itemCount: productData.items.length,
            ),
          ),
        ));
  }
}
