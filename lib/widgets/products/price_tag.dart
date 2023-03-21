import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  const PriceTag(this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),),
      child: Text(
        '\$$price',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
