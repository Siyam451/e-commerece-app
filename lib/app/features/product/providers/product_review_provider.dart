import 'package:flutter/material.dart';

import '../../../set_up_network_caller.dart';
import '../../../urls.dart';
import '../data/models/product_review_model.dart';

class ProductReviewProvider extends ChangeNotifier {
  final int _pageSize = 30;
  int _currentPageNo = 0;
  int? _lastPageNo;

  bool _initialLoading = false;
  bool _loadingMoreData = false;

  final List<ProductReviewModel> _productReviewList = [];
  String? _errorMessage;

  bool get initialLoading => _initialLoading;
  bool get loadingMoreData => _loadingMoreData;
  List<ProductReviewModel> get productReviewList => _productReviewList;
  String? get errorMessage => _errorMessage;

  /// 🔄 Load first page
  Future<void> loadInitialProductReview(String productId) async {
    _currentPageNo = 0;
    _lastPageNo = null;
    _productReviewList.clear();
    await getProductReview(productId);
  }

  /// ⬇️ Load next pages
  Future<bool> loadMoreProductReview(String productId) async {
    if (_loadingMoreData) return false;
    if (_lastPageNo != null && _currentPageNo >= _lastPageNo!) {
      return false;
    }
    return getProductReview(productId);
  }

  /// 🔧 Internal API call
  Future<bool> getProductReview(String productId) async {
    bool isSuccess = false;

    if (_currentPageNo == 0) {
      _initialLoading = true;
    } else {
      _loadingMoreData = true;
    }
    notifyListeners();

    _currentPageNo++;

    final response = await getNetworkcaller().getRequest(
      url: Urls.ProductReviewUrl(_currentPageNo, productId),
    );

    if (response.isSuccess) {
      _lastPageNo = response.responseData['data']['last_page'];

      final results = response.responseData['data']['results'] as List;
      _productReviewList.addAll(
        results.map((e) => ProductReviewModel.fromJson(e)).toList(),
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
}