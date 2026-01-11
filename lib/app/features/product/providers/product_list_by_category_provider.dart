import 'package:flutter/material.dart';

import '../../../core/services/network_api_caller.dart';
import '../../../set_up_network_caller.dart';
import '../../../urls.dart';
import '../data/models/product_model.dart';

class ProductListByCategoryProvider extends ChangeNotifier {
  final int _pageSize = 30;
  int _currentPageNo = 0;
  int? _lastPageNo;

  bool _initialLoading = false;
  bool _loadingMoreData = false;

  final List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get initialLoading => _initialLoading;
  bool get loadingMoreData => _loadingMoreData;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;

  Future<bool> fetchproductList(String categoryId) async {
    bool isSuccess = false;
    //  stop if last page reached
    if (_lastPageNo != null && _currentPageNo >= _lastPageNo!) {
      return false;
    }

    if (_currentPageNo == 0) {
      _productList.clear();
      _initialLoading = true;
    } else {
      _loadingMoreData = true;
    }

    notifyListeners();

    _currentPageNo++;

    final NetworkResponse response = await getNetworkcaller().getRequest(
      url: Urls.ProductListbyCategory(
        _pageSize,
        _currentPageNo,
        categoryId,
      ),
    );

    if (response.isSuccess) {
      _lastPageNo = response.responseData['data']['last_page'];

      final results = response.responseData['data']['results'] as List;
      _productList.addAll(
        results.map((e) => ProductModel.fromJson(e)).toList(),
      );

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _initialLoading = false;
    _loadingMoreData = false;

    notifyListeners();
    return isSuccess;
  }

  Future<void> loadInitialProductListbyCategory(String categoryId) async {
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchproductList(categoryId);
  }
}
