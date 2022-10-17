import 'package:flutter/material.dart';
import 'package:shop_app/widgets/text_formfield_widget.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);
  static const routName = 'product-edit-screen';

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit your product'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Form(
          child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: TextFormFieldWidget(
                      label: 'Title',
                      inputAction: TextInputAction.next,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextFormFieldWidget(
                  label: 'Price',
                  inputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormFieldWidget(
              label: 'Discription',
              keyboardType: TextInputType.multiline,
              maxLines: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormFieldWidget(
              label: 'ImageUrl',
              inputAction: TextInputAction.done,
            )
          ],
        ),
      )),
    );
  }
}
