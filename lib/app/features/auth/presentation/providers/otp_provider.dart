import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/features/auth/Data/Models/sign_up-params.dart';
import 'package:ecommerce_project/app/features/auth/Data/Models/verify_otp_params.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/material.dart';

class VerifyOtpProvider extends ChangeNotifier{
  bool _verifyotpInProgress = false;
  bool get verifyOtpInProgress  => _verifyotpInProgress;

  String? _errorMassege ;
  String? get errorMassege  => _errorMassege;

//work for provider
  Future<bool>verifyOtp(VerifyOtpParams params) async{

    bool isSuccess = false;
    _verifyotpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkcaller().postRequest(
        url: Urls.VerifyOtpUrl,
        body: params.toJson()
      // params bolte mainly aikane amra postman e signup er jonno j body ta chilo seita signupparams diye file banaisi

    );

    if(response.isSuccess){
      isSuccess = true;
      _errorMassege = null;
    }else{
      _errorMassege = response.errorMessage;
    }

    _verifyotpInProgress = false;
    notifyListeners();
    return isSuccess;

  }
}
