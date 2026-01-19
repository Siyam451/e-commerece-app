import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier{
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void _logIn(){
    _isLoggedIn = true;
    notifyListeners();
  }

  void _logOut(){
    _isLoggedIn = false;
    notifyListeners();
  }
}