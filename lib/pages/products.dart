import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../widgets/products/products.dart';
import '../scoped-models/main.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  const ProductsPage(this.model, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}
class _ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    widget.model.fetchProducts();
    super.initState();
  }

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

  Widget _buildProductsList() {
    return ScopedModelDescendant(builder: (BuildContext context, Widget? child, MainModel model) {
      Widget content = Center(child: Text('no products found'));
      if(model.displayedProducts.length > 0 && !model.isLoading) {
        content = Products();
      } else if(model.isLoading) {
        content = Center(child: CircularProgressIndicator(color: Colors.green),);
      }
      return RefreshIndicator(onRefresh: model.fetchProducts, child: content);
    },);
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
      body: _buildProductsList(),
    );
  }
}
