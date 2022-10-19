import 'package:flutter/material.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/text_formfield_widget.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({Key? key}) : super(key: key);
  static const routName = 'product-edit-screen';

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final TextEditingController _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
      id: null, imageUrl: null, description: null, price: null, title: null);
  var _ischanged = true;
  var _isLoading = false;
  var _initValues = {
    'id': '',
    'title': '',
    'discription': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void didChangeDependencies() {
    if (_ischanged) {
      final productId = ModalRoute.of(context)!.settings.arguments as String?;
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context).selectById(productId);
        _initValues = {
          'id': _editedProduct.id!,
          'title': _editedProduct.title!,
          'discription': _editedProduct.description!,
          'price': _editedProduct.price!.toString(),
          'imageUrl': _imageUrlController.text = _editedProduct.imageUrl!,
        };
      }
    }

    _ischanged = false;

    super.didChangeDependencies();
  }

  void _onSave() {
    var isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
      setState(() {
        _isLoading = false;
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
            print(error);
        return showDialog(
            context: context,
            builder: (ctx) {
              return  AlertDialog(
                title: const Text('An error ocurred'),
                content:  Text(error.toString()),
                actions: [TextButton(onPressed: (){
                  Navigator.of(ctx).pop();
                }, child: const Text('Okay'))],
              );
            });
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }

    // print(_editedProduct.id);
    // print(_editedProduct.title);
    // print(_editedProduct.price);
    // print(_editedProduct.description);
    // print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit your product'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(onPressed: _onSave, icon: const Icon(Icons.save))
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                    key: _form,
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
                                    initValue: _initValues['title'],
                                    label: 'Title',
                                    inputAction: TextInputAction.next,
                                    onSaved: (value) {
                                      _editedProduct = Product(
                                        isFavorite: _editedProduct.isFavorite,
                                        id: _editedProduct.id,
                                        imageUrl: _editedProduct.imageUrl,
                                        description: _editedProduct.description,
                                        price: _editedProduct.price,
                                        title: value,
                                      );
                                    },
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return 'Enter Title';
                                      }
                                      return null;
                                    },
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormFieldWidget(
                                  initValue: _initValues['price'],
                                  label: 'Price',
                                  inputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  onSaved: (value) {
                                    _editedProduct = Product(
                                      isFavorite: _editedProduct.isFavorite,
                                      id: _editedProduct.id,
                                      imageUrl: _editedProduct.imageUrl,
                                      description: _editedProduct.description,
                                      price: double.parse(value!),
                                      title: _editedProduct.title,
                                    );
                                  },
                                  validate: (val) {
                                    if (val!.isEmpty) {
                                      return 'Enter Price';
                                    } else if (double.tryParse(val) == null) {
                                      return 'Only Integers';
                                    } else if (double.parse(val) <= 0) {
                                      return 'Not Valid';
                                    }
                                    return null;
                                  },
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            initValue: _initValues['discription'],
                            label: 'Discription',
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            onSaved: (value) {
                              _editedProduct = Product(
                                isFavorite: _editedProduct.isFavorite,
                                id: _editedProduct.id,
                                imageUrl: _editedProduct.imageUrl,
                                description: value,
                                price: _editedProduct.price,
                                title: _editedProduct.title,
                              );
                            },
                            validate: (val) {
                              if (val!.isEmpty) {
                                return 'Enter discription';
                              } else if (val.length < 10) {
                                return 'Add more Discription';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        left: Radius.circular(10),
                                        right: Radius.circular(10),
                                      )),
                                  child: _imageUrlController.text.isEmpty
                                      ? Container(
                                          alignment: Alignment.center,
                                          child: const Text('Enter Url'))
                                      : Image(
                                          image: NetworkImage(
                                              _imageUrlController.text)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    label: 'ImageUrl',
                                    inputAction: TextInputAction.done,
                                    keyboardType: TextInputType.url,
                                    controller: _imageUrlController,
                                    editingComplete: () {
                                      setState(() {});
                                    },
                                    onFieldSubmitted: (_) {
                                      _onSave();
                                    },
                                    onSaved: (value) {
                                      _editedProduct = Product(
                                        isFavorite: _editedProduct.isFavorite,
                                        id: _editedProduct.id,
                                        imageUrl: value,
                                        description: _editedProduct.description,
                                        price: _editedProduct.price,
                                        title: _editedProduct.title,
                                      );
                                    },
                                    validate: (val) {
                                      if (val!.isEmpty) {
                                        return 'Enter Image Url';
                                      } else if (!val.startsWith('http') &&
                                          !val.startsWith('https')) {
                                        return 'Enter valid Url';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ])
                        ],
                      ),
                    )),
              ),
      ),
    );
  }
}
