class Urls {
  static const String _baseUrl = "https://ecom-rs8e.onrender.com/api";
  static const String SignupUrl = "$_baseUrl/auth/signup";
  static const String VerifyOtpUrl = "$_baseUrl/auth/verify-otp";
  static const String SignInUrl = "$_baseUrl/auth/login";
  static const String homeSlidersUrl = '$_baseUrl/slides';
  static String CategoryListUrl(int pagesize,int PageNo) =>
      "$_baseUrl/categories?count=$pagesize&page=$PageNo";
  static String ProductListbyCategory(int pagesize,int pageNo,String categoryId) =>
    "$_baseUrl/products?count=$pagesize&page=$pageNo&category=$categoryId";

  static String ProductDetails(String productId) =>'$_baseUrl/products/id/$productId';

  static const String addtoCartUrl = '$_baseUrl/cart';
  static  String CartListUrl(int? count) => '$_baseUrl/cart?count=$count';

  static String cartListDeleteUrl(String cartItemId) {
    return '$_baseUrl/cart/$cartItemId';
  }
  static const String createProductReviewUrl = '$_baseUrl/review';
  static String ProductReviewUrl(int count,String productId) =>
      "$_baseUrl/reviews?count=$count&product=$productId";


}