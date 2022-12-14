import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final productId;
  final id;
  final price;
  final title;
  final quantity;

  CartItem(this.productId, this.id, this.price, this.title, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: const Padding(
            padding: EdgeInsets.only(right: 20), child: Icon(Icons.delete)),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeFromCart(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you need to delete this item?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No'),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text('yes'),
              ),
            ],
          ),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text('\$$price'),
            ),
            radius: 35,
          ),
          title: Text(title),
          subtitle: Text('Total : \$${(price * quantity)}'),
          trailing: Text('X ${quantity} '),
        ),
      ),
    );
  }
}
