import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_edit_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
class UserProductWidget extends StatelessWidget {
  const UserProductWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.id,
  }) : super(key: key);
  final String? id;
  final String? imageUrl;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl!)),
          title: Text(title!),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ProductEditScreen.routName, arguments: id);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                    )),
                IconButton(
                    onPressed: () {
                      Provider.of<Products>(context,listen: false).deleteProduct(id!);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
