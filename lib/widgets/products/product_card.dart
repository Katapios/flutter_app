import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import './address_tag.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

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
          PriceTag(
            product.price.toString(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder:
        (BuildContext context, Widget? child, MainModel model) {return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () =>
              Navigator.pushNamed<dynamic>(context, '/product/' + model.allProducts[productIndex].id),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
        ),
          IconButton(
            icon: Icon(
              model.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () => {
              model.selectProduct(model.allProducts[productIndex].id),
              model.toggleProductFavoriteStatus(),
            },
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
          ),

      ]);},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: <Widget>[
        FadeInImage(placeholder: AssetImage('assets/gaika.png'), image: NetworkImage(product.image)),
        _buildTitlePriceRow(),
        const AddressTag('Union Square, San Francisco'),
        Text(product.userEmail),
        _buildActionButtons(context),
      ],
    ));
  }
}
