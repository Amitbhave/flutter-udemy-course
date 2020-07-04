import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {

  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();

}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var isInit = true;
  var _editedProduct = Product(id: null, title: '', price: 0, description: '', imageUrl: '',);
  var _initValues = {
    'title': '',
    'price': 0,
    'description': '',
    'imageUrl': '',
  };
  var _isLoading = false;
  
  @override
  void initState() {
    super.initState();
    _imageUrlFocusNode.addListener(_updateImageUrl);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null) {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
  }

  void _updateImageUrl() {
    if(!_imageUrlFocusNode.hasFocus) {
      setState(() {
      });
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if(!isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if(_editedProduct.id != null) {
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct)
      .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Please enter title.';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    isFavourite: _editedProduct.isFavourite,
                    title: value,
                    price: _editedProduct.price,
                    description: _editedProduct.description,
                    imageUrl: _editedProduct.imageUrl
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Please enter price.';
                  }
                  if(double.tryParse(value) == null) {
                    return 'Please enter valid number';
                  }
                  if(double.parse(value) <= 0) {
                    return 'Please enter number greater than 0';
                  }
                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      price: double.parse(value),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if(value.isEmpty) {
                    return 'Please enter description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      isFavourite: _editedProduct.isFavourite,
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value,
                      imageUrl: _editedProduct.imageUrl
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10,),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                    ),
                    child: _imageUrlController.text.isEmpty ? Text('Enter a URL') : FittedBox(
                      child: Image.network(_imageUrlController.text, fit: BoxFit.cover,),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter image url.';
                        }
                        if(!value.startsWith('http') && !value.startsWith('https') && !value.endsWith('.png') && !value.endsWith('.jpg') && !value.endsWith('.jpeg')) {
                          return 'Please enter valid image url.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => {
                        _saveForm
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            isFavourite: _editedProduct.isFavourite,
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: value
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}