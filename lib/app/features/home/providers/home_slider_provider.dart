import 'package:ecommerce_project/app/core/services/network_api_caller.dart';
import 'package:ecommerce_project/app/features/home/models/sliders_model.dart';
import 'package:ecommerce_project/app/set_up_network_caller.dart';
import 'package:ecommerce_project/app/urls.dart';
import 'package:flutter/material.dart';

class HomeSliderProvider extends ChangeNotifier{

  bool _getHomeSliderInProgress = false;
  bool get getHomeSliderInprogress => _getHomeSliderInProgress;

  List<SliderModel> _HomeSliderList = [];
  List<SliderModel> get homeSliderList => _HomeSliderList;

  String? _errorMassege;
  String? get errorMassage => _errorMassege;

  Future<bool> gethomeSlider()async{
    bool isSuccess = false;
    _getHomeSliderInProgress = true;
    notifyListeners();
    
    final NetworkResponse response = await getNetworkcaller().getRequest(url: Urls.homeSlidersUrl);

    if(response.isSuccess){
      List<SliderModel> Sliders = [];
      for(Map<String,dynamic> sliders in response.responseData['data']['results']){
        Sliders.add(SliderModel.fromJson(sliders));
        _HomeSliderList = Sliders;
        isSuccess = true;
      }

    }else{
      _errorMassege = response.errorMessage;
    }

    _getHomeSliderInProgress= false;
    notifyListeners();
    return isSuccess;
  }
}