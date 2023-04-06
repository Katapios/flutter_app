import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';
import 'connected_products.dart';
import 'connected_products.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int? _selProductIndex;
  User? _authenticatedUser;
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, String image, double price) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image':
          'https://www.superplanshet.ru/images/Samsung_Galaxy_Z_Fold4_A1Ql05.jpg',
      'price': price,
      'userEmail' : _authenticatedUser?.email,
      'userId' : _authenticatedUser?.id
    };

    return http
        .post(
            Uri.parse(
                'https://flutterdennisintroduction-default-rtdb.firebaseio.com/products.json'),
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: _authenticatedUser!.email,
          userId: _authenticatedUser!.id);
      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
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
          id: '',
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

  void updateProduct(
      String title, String description, String image, double price) {
    final Product updatedProduct = Product(
        id: '',
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

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http.get(Uri.parse('https://flutterdennisintroduction-default-rtdb.firebaseio.com/products.json'))
        .then((http.Response response) {
      final List<Product> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      if(productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          price: productData['price'],
          image: productData['image'],
          userEmail: productData['userEmail'],
          userId: productData['userId'],
        );
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
    });
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
        userId: selectedProduct.userId, id: '');
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

mixin UserModel on ConnectedProductsModel {
  //ConnectedProductsModel myModel = ConnectedProductsModel();

  void login(String email, String password) {
    _authenticatedUser = User(id: 'asdas', email: email, password: password);
  }
}

mixin UtilityModel on ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
