import 'dart:async';
import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../widgets/ui_elements/title_default.dart';
import '../models/product.dart';
import '../scoped-models/products.dart';


class ProductPage extends StatelessWidget {
  final int productIndex;

  const ProductPage(this.productIndex);

  Widget _buildAddressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'Union Square, San Francisco',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          child: const Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$$price',
          style: const TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      }, child: ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget? child, ProductsModel model){
        final Product product = model.products[productIndex];
        return Scaffold(
          appBar: AppBar(
            title: Text(product.title),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(product.image),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              _buildAddressPriceRow(product.price),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        );
      },
    ),

    );
  }
}
