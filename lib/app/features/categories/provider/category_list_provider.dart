import '../../../core/services/network_api_caller.dart';
import '../../../set_up_network_caller.dart';
import '../../../urls.dart';
import '../models/category_model.dart';

import 'package:flutter/material.dart';
class CategoryListProvider extends ChangeNotifier {
  final int _pageSize = 30;

  int _currentPageNo = 0;
  int? _lastPageNo;

  bool _initLoading = false;
  bool _loadmoreData = false;

  String? _errormassage;

  final List<CategoryModel> _categorylist = [];

  bool get initloading => _initLoading;
  bool get loadingmoreData => _loadmoreData;
  String? get errormassage => _errormassage;
  List<CategoryModel> get categorylist => _categorylist;

  Future<bool> fetchCategoryList() async {
    if (_initLoading || _loadmoreData) return false;

    bool isSuccess = false;

    if (_currentPageNo == 0) {
      _categorylist.clear();
      _initLoading = true;
    } else if (_lastPageNo != null && _currentPageNo < _lastPageNo!) {
      _loadmoreData = true;
    } else {
      return false;
    }

    notifyListeners();

    _currentPageNo++;

    final NetworkResponse response =
    await getNetworkcaller().getRequest(
      url: Urls.CategoryListUrl(_pageSize, _currentPageNo),
    );

    if (response.isSuccess) {
      _lastPageNo = response.responseData['data']['last_page'];

      final List<CategoryModel> list = [];
      for (Map<String, dynamic> jsonData
      in response.responseData['data']['results']) {
        list.add(CategoryModel.fromJson(jsonData));
      }

      _categorylist.addAll(list); // ✅ FIXED
      isSuccess = true;
    } else {
      _errormassage = response.errorMessage;
    }

    _initLoading = false;
    _loadmoreData = false;

    notifyListeners();
    return isSuccess;
  }

  Future<void> loadInitialCategoryList() async {
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchCategoryList();
  }
}
