import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/features/auth/Data/Models/sign_in_params.dart';
import 'package:ecommerce_project/app/features/auth/Data/Models/user_model.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/material.dart';

import 'auth_controller.dart';

class SigninProvider extends ChangeNotifier{
   bool _isSignInprogress = false;
   bool get IsSignInProgress => _isSignInprogress;

   String? _errorMassege;
   String? get errorMassege => _errorMassege;

   Future<bool> SignIn(SignInParams params)async{
     bool isSuccess = false;

     _isSignInprogress = true;
     notifyListeners();

     final NetworkResponse response =  await getNetworkcaller().postRequest(
       url: Urls.SignInUrl,
       body: params.toJson()
     );
     if(response.isSuccess){

       UserModel model = UserModel.fromJson(response.responseData['data']['user']);
       String accessToken = response.responseData['data']['token'];
       await AuthController.saveUserData(accessToken, model); //userData jate save thake tai

       isSuccess = true;
       _errorMassege = null;

     }else{
       _errorMassege = response.errorMessage;
     }
     _isSignInprogress = false;
     notifyListeners();
     return isSuccess;
   }
}