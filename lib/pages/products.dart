import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

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
          ScopedModelDescendant<MainModel>(builder:
              (BuildContext context, Widget? child, MainModel model) {
            return IconButton(
                onPressed: () => {
                  model.toggleDisplayMode(),
                }, icon: Icon(
              model.displayFavoritesOnly ?
                Icons.favorite_outline : Icons.favorite_border,
            ));
          })
        ],
      ),
      body: const Products(),
    );
  }
}
