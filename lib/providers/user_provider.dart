

import 'package:flutter/cupertino.dart';
import 'package:m2i_cours_flutter/models/user_model.dart';

class UserProvider with  ChangeNotifier {

  UserModel? _user;

  UserModel? get user => _user;

  bool get isLoggedIn => _user != null;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

}