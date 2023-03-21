import 'package:flutter/material.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  const ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleDefault(product.title),
            const SizedBox(
              width: 8.0,
            ),
            PriceTag(product.price.toString(),),
          ],
        ),);
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pushNamed<dynamic>(
              context, '/product/$productIndex'),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red)),
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border, color: Colors.red,),
          onPressed: () => {},
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: <Widget>[
            Image.asset(product.image),
            _buildTitlePriceRow(),
            const AddressTag('Union Square, San Francisco'),
            _buildActionButtons(context),
          ],
        ));
  }
}
