import 'package:denns_introduction_app/scoped-models/main.dart';
import 'package:denns_introduction_app/widgets/products/product_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/product.dart';
import '../../scoped-models/main.dart';

class Products extends StatelessWidget {
  const Products({super.key});


  Widget _buildProductList(List<Product> products) {
    Widget productCards;

    if (products.isNotEmpty) {
      productCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      productCards = Container();
    }
    return productCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant <MainModel>(builder: (BuildContext context, Widget? child, MainModel model){
      return _buildProductList(model.displayedProducts);
    },);
  }
}
