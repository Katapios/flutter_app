import 'package:flutter/material.dart';

class ProductEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final Map<String, dynamic> product;
  final int productIndex;

  ProductEditPage({required this.addProduct, required this.updateProduct, required this.product, required this.productIndex});

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

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'product title'),
      initialValue: widget.product.isEmpty ? '' : widget.product['title'],
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 5) {
          return 'Please type 5 or more characters to title';
        }
        return null;
      },
      onSaved: (String? value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'product description'),
      initialValue:
      widget.product.isEmpty ? '' : widget.product['description'],
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
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'product price'),
      initialValue:
      widget.product.isEmpty ? '' : widget.product['price'].toString(),
      validator: (dynamic value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
      keyboardType: TextInputType.number,
      onSaved: (String? value) {
        _formData['price'] = double.parse(value!);
      },
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();
    //widget.addProduct(_formData);

    if (widget.product.isEmpty) {
      widget.addProduct(_formData);
    } else {
      widget.updateProduct(widget.productIndex, _formData);
    }

    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    final Widget pageContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white),
                onPressed: _submitForm,
                child: Text('Save'),
              ),
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
    return widget.product == null
        ? pageContent
        : Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
      ),
      body: pageContent,
    );
  }
}
