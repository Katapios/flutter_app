import 'package:flutter/material.dart';
import './connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with ConnectedProductsModel, UserModel, ProductsModel, UtilityModel {}