import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/features/cartList/data/models/cart_list_model.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/material.dart';

class CartListProvider extends ChangeNotifier{
  bool _cartListInprogress = false;
  bool get cartlistinprogress => _cartListInprogress;

  String? _errormassage;
  String? get errormassage => _errormassage;

  List<CartItem> _cartItem = [];
  List<CartItem> get cartItem => _cartItem;

  int get totalItem => _cartItem.length;

  double get totalPrice{
    double total = 0;
    for(final item in _cartItem){
      total += item.price * item.quantity;//joto item add hbe price toto barbe
    }
    return total;
  }


  Future<bool> getcartList(int? count)async{
    bool isSucess = false;
    _cartListInprogress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkcaller().getRequest(
      url: Urls.CartListUrl(count),
    );
    if(response.isSuccess){

      final results = response.responseData['data']['results'] as List;

      _cartItem =results.map((item)=> CartItem.fromJson(item)).toList();

      isSucess = true;
      _errormassage = null;

    }else{
      _errormassage = response.errorMessage;
    }

    _cartListInprogress = false;
    notifyListeners();
    return isSucess;
  }
}