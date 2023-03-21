import 'package:flutter/material.dart';
import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Choose'),
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: const Text('EasyList'),
        actions: [
          IconButton(onPressed: () => {}, icon: const Icon(Icons.favorite_outline))
        ],
      ),
      body: const Products(),
    );
  }
}
