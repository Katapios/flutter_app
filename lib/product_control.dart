import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function addProduct;
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // background
        onPrimary: Colors.white, // foreground
      ),
      //style: ElevatedButton.styleFrom(backgroundColor: Colors.green),

      onPressed: () {
        addProduct({'title': 'Chocolate', 'image': 'assets/gaika.png'});
      },
      child: Text('add product'),
    );
  }
}
