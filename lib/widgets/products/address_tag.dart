import 'package:flutter/material.dart';

class AddressTag extends StatelessWidget {
  final String address;

  const AddressTag(this.address, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.grey),
          borderRadius: BorderRadius.circular(4.0)),
      child: Text(address),
    );
  }
}
