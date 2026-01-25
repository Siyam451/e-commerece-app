import 'package:flutter/material.dart';

import '../../../core/services/network_api_caller.dart';
import '../../../set_up_network_caller.dart';
import '../../../urls.dart';
import '../data/models/product_review_model.dart';

class ProductReviewProvider extends ChangeNotifier {
  // final int _pageSize = 30;
  int _currentPageNo = 0;
  int? _lastPageNo;

  bool _initialLoading = false;
  bool _loadingMoreData = false;

  final List<ProductReviewModel> _reviewList = [];
  String? _errorMessage;

  bool get initialLoading => _initialLoading;
  bool get loadingMoreData => _loadingMoreData;
  List<ProductReviewModel> get reviewList => _reviewList;
  String? get errorMessage => _errorMessage;

  /* ================= FETCH (same pattern) ================= */

  Future<bool> fetchProductReviews(String productId) async {
    bool isSuccess = false;

    // stop if last page reached
    if (_lastPageNo != null && _currentPageNo >= _lastPageNo!) {
      return false;
    }

    if (_currentPageNo == 0) {
      _reviewList.clear();
      _initialLoading = true;
    } else {
      _loadingMoreData = true;
    }

    notifyListeners();

    _currentPageNo++;

    final NetworkResponse response =
    await getNetworkcaller().getRequest(
      url: Urls.ProductReviewUrl(
        _currentPageNo,
        productId,
      ),
    );

    if (response.isSuccess) {
      _lastPageNo = response.responseData['data']['last_page'];

      final results =
      response.responseData['data']['results'] as List;

      _reviewList.addAll(
        results
            .map((e) => ProductReviewModel.fromJson(e))
            .toList(),
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

  /* ================= INITIAL LOAD ================= */

  Future<void> loadInitialProductReviews(String productId) async {
    _currentPageNo = 0;
    _lastPageNo = null;
    await fetchProductReviews(productId);
  }


  void addNewReview(ProductReviewModel review) {
    _reviewList.insert(0, review); // newest on top
    notifyListeners();
  }
}
