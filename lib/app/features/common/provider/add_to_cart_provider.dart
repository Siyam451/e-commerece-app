import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/material.dart';

class AddToCartProvider extends ChangeNotifier{
  bool _AddtocartInprogress = false;
  bool get addtocartinprogress => _AddtocartInprogress;
  
  String? _errormassage;
  String? get errormassage => _errormassage;
  
  
  Future<bool> addtocart(String productId)async{
    bool isSucess = false;
    _AddtocartInprogress = true;
    notifyListeners();
    Map<String,dynamic> requestbody ={
      "product": productId,
    };
    final NetworkResponse response = await getNetworkcaller().postRequest(
        url: Urls.addtoCartUrl,
      body: requestbody,
    );
    if(response.isSuccess){
      isSucess = true;
      _errormassage = null;

    }else{
      _errormassage = response.errorMessage;
    }

    _AddtocartInprogress = false;
    notifyListeners();
    return isSucess;
  }
}