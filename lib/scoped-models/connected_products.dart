import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int? _selProductIndex;
  User? _authenticatedUser;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticatedUser!.email,
        userId: _authenticatedUser!.id);
    _products.add(newProduct);
    // _selProductIndex = null;
    print(_authenticatedUser!.id.toString());
    notifyListeners();
  }
}

mixin ProductsModel on ConnectedProductsModel{

  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if(_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int? get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return Product(
          title: '',
          description: '',
          image: '',
          price: double.nan,
          userEmail: '',
          userId: '');
    }
    return _products[selectedProductIndex!];
  }


  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  void updateProduct(String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: 'selectedProduct.userEmail',
        userId: 'selectedProduct.userId');
    _products[selectedProductIndex!] = updatedProduct;
    // _selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    // _products.removeAt(selectedProductIndex!);
    // _selProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId
    );
    _products[selectedProductIndex!] = updatedProduct;
    // _selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    // _selProductIndex = null;
    notifyListeners();
  }

}


mixin UserModel on ConnectedProductsModel{
  //ConnectedProductsModel myModel = ConnectedProductsModel();

  void login(String email, String password){
    _authenticatedUser = User(id: 'asdas', email: email, password: password);
  }

}