import 'package:flutter/material.dart';
import 'package:denns_introduction_app/scoped-models/products.dart';
import 'package:denns_introduction_app/scoped-models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with UserModel, ProductsModel {}