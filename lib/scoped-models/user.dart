import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';

class UserModel extends Object{
  User? _autenticatedUser;

  void login(String email, String password){
    _autenticatedUser = User(id: 'asdas', email: email, password: password);
  }

}