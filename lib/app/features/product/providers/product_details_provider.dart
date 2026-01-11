import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/features/product/data/models/product_details_model.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/widgets.dart';

class ProductDetailsProvider extends ChangeNotifier{
  bool _productDetailsInprogress = false;
  bool get ProductDetailsInprogress => _productDetailsInprogress;

  ProductDetailsModel? _productDetailsModel;

  ProductDetailsModel? get productdetailmodel => _productDetailsModel;


  String? _errormasseage;
  String? get errormassage => _errormasseage;

  Future <bool> getproductdetails(String productId)async{
    bool isSucesss = false;
    _productDetailsInprogress = true;
    notifyListeners();
    
    final NetworkResponse response = await getNetworkcaller().getRequest(url: Urls.ProductDetails(productId));

    if(response.isSuccess){
      isSucesss = true;
      _productDetailsModel = ProductDetailsModel.fromJson(response.responseData['data']);
      _errormasseage = null;
    }else{
      _errormasseage = response.errorMessage;

    }

    _productDetailsInprogress = false;
    notifyListeners();


    return isSucesss;
  }
}