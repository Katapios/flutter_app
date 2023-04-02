import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/main.dart';
import '../pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});


  Widget _buildEditButton (BuildContext context, int index, MainModel model) {
      return IconButton(
        icon: const Icon(Icons.edit),
        onPressed: () {
          model.selectProduct(index);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductEditPage();
              },
            ),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget? child, MainModel model){
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          print('my index is ' + index.toString());
          return Dismissible(
            key: Key(model.allProducts[index].title),
            onDismissed: (DismissDirection direction) {
              if(direction == DismissDirection.endToStart) {
                model.selectProduct(index);
                model.deleteProduct();
              } else if (direction == DismissDirection.startToEnd) {
                print('swipe start to end');
              } else {
                print('other swiping');
              }
            },
            background: Container(margin: const EdgeInsets.only(bottom: 15),color: Colors.amber,),
            child: Column(
              children: [
                ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(model.allProducts[index].image),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle: Text('\$${model.allProducts[index].price.toString()}'),
                    trailing: _buildEditButton(context, index, model)
                ),
                const Divider(color: Colors.grey, thickness: 1),
              ],
            ),);
        },
        itemCount: model.allProducts.length,
      );
    },),


    );
  }
}
