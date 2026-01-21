import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/material.dart';

class CreateProductReviewProvider extends ChangeNotifier{
  bool _createproductReviewInprogress = false;
  bool get createproductReviewInprogress => _createproductReviewInprogress;

  String? _errormassage;
  String? get errormassage => _errormassage;


  Future<bool> createProductReview(String productId,String createReview,int rating)async{
    bool isSucess = false;
    _createproductReviewInprogress = true;
    notifyListeners();
    Map<String,dynamic> requestbody ={
      "product": productId,
      "comment":createReview,
      "rating":rating
    };
    final NetworkResponse response = await getNetworkcaller().postRequest(
      url: Urls.createProductReviewUrl,
      body: requestbody,
    );
    if(response.isSuccess){
      isSucess = true;
      _errormassage = null;

    }else{
      _errormassage = response.errorMessage;
    }

    _createproductReviewInprogress = false;
    notifyListeners();
    return isSucess;
  }
}