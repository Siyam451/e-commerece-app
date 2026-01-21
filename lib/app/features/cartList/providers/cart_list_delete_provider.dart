
import 'package:flutter/material.dart';
import '../../../core/services/network_api_caller.dart';
import '../../../set_up_network_caller.dart';
import '../../../urls.dart';
import '../data/models/cart_list_model.dart';
class CartListDeleteProvider extends ChangeNotifier {
  final List<CartItem> _cartItem = [];

  List<CartItem> get cartItem => _cartItem;

  bool _deleteInProgress = false;
  bool get deleteInprogress => _deleteInProgress;

  String? _errormassage;
  String? get errormassage => _errormassage;

  String? _deletingItemId;
  String? get deletingItemId => _deletingItemId;



  Future<bool> changedeleteStatus(BuildContext context, String cartItemId)async {

    bool isSucess = false;
    _deleteInProgress = true;
    _deletingItemId = cartItemId;
    notifyListeners();

    final NetworkResponse response = await getNetworkcaller().deleteRequest(

        url: Urls.cartListDeleteUrl(cartItemId));

    if (response.isSuccess) {
     isSucess = true;
     _errormassage = null;


    } else {
     _errormassage = response.errorMessage;
    }
    _deleteInProgress = false;
    _deletingItemId = null;
    notifyListeners();
    return isSucess;
  }


}
