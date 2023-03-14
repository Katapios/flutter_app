import 'package:flutter/material.dart';

class ProductCreatePage extends StatelessWidget {
  const ProductCreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green, foregroundColor: Colors.white),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Text('This is a modal'),
                );
              });
        },
        child: Text('Save'),
      ),
    );
  }
}
