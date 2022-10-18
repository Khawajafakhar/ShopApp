import 'package:flutter/material.dart';
import '../providers/products.dart';

class UserProductWidget extends StatelessWidget {
  const UserProductWidget(
      {Key? key, @required this.imageUrl, @required this.title})
      : super(key: key);
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
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.grey,
                    )),
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              ],
            ),
          ),
        ),
       const Divider(),
      ],
    );
  }
}
