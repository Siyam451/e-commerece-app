import 'package:flutter/cupertino.dart';

import '../../../../core/services/network_api_caller.dart';
import '../../../../set_up_network_caller.dart';
import '../../../../urls.dart';
import '../../Data/Models/sign_up-params.dart';

class SignupProvider extends ChangeNotifier {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;

  String? _errorMassege;
  String? get errorMassege => _errorMassege;

  Future<bool> signUp(SignUpParams params) async {
    bool isSuccess = false;


    _signUpInProgress = true;
    notifyListeners();

    final NetworkResponse response = await getNetworkcaller().postRequest(
      url: Urls.SignupUrl,
      body: params.toJson(),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMassege = null;
    } else {
      _errorMassege = response.errorMessage;
    }

    _signUpInProgress = false;
    notifyListeners();

    return isSuccess;
  }
}
