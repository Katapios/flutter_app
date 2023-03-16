import 'package:denns_introduction_app/widgets/products/address_tag.dart';
import 'package:denns_introduction_app/widgets/products/price_tag.dart';
import 'package:denns_introduction_app/widgets/ui_elements/titile_default.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleDefault(product['title']),
            SizedBox(
              width: 8.0,
            ),
            PriceTag(product['price'].toString(),),
          ],
        ),);
  }

  Widget _buildActionButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pushNamed<dynamic>(
              context, '/product/' + productIndex.toString()),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red)),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border, color: Colors.red,),
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
            Image.asset(product['image']!),
            _buildTitlePriceRow(),
            AddressTag('Union Square, San Francisco'),
            _buildActionButtons(context),
          ],
        ));
  }
}