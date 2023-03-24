import 'package:flutter/material.dart';

import '../widgets/helpers/ensure_visible.dart';
import '../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';

class ProductEditPage extends StatefulWidget {

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/gaika.png',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: const InputDecoration(labelText: 'product title'),
        initialValue: product.title.isEmpty ? '' : product.title,
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 5) {
            return 'Please type 5 or more characters to title';
          }
          return null;
        },
        onSaved: (String? value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: const InputDecoration(labelText: 'product description'),
        initialValue:
            product.description.isEmpty ? '' : product.description,
        validator: (value) {
          if (value == null || value.isEmpty || value.length < 10) {
            return 'Please type 10 or more characters to description';
          }
          return null;
        },
        maxLines: 4,
        onSaved: (String? value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: const InputDecoration(labelText: 'product price'),
        initialValue:
            product.price.isNaN ? '' : product.price.toString(),
        validator: (dynamic value) {
          // if (value.trim().length <= 0) {
          if (value.isEmpty ||
              !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price is required and should be a number.';
          }
          return null;
        },
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _formData['price'] = double.parse(value!);
        },
      ),
    );
  }

  Widget _buildSubmitbutton() {
      return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget? child, MainModel model) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, foregroundColor: Colors.white),
                onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectedProductIndex),
                child: const Text('Save'),
              );
        },
      );
  }

  Widget _buildPageContent (BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              const SizedBox(
                height: 10.0,
              ),
              _buildSubmitbutton(),
              // GestureDetector(
              //   onTap: _submitForm,
              //   child: Container(
              //   color: Colors.green,
              //   padding: EdgeInsets.all(5.0),
              //   child: Text('my button'),
              // ),)
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, [int? selectedProductIndex]) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    //widget.addProduct(_formData);

    if (selectedProductIndex == null) {
      print("addIndex= " + selectedProductIndex.toString());
      addProduct(
        Product(
            title: _formData['title'],
            description: _formData['description'],
            price: _formData['price'],
            image: _formData['image']),
      );
    } else {
      print("updateIndex= " + selectedProductIndex.toString());
      updateProduct(
        Product(
            title: _formData['title'],
            description: _formData['description'],
            price: _formData['price'],
            image: _formData['image']),
      );
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget? child, MainModel model) {
        final Widget pageContent =
        _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
          appBar: AppBar(
            title: Text('Edit Product'),
          ),
          body: pageContent,
        );
      },
    );
  }



}
