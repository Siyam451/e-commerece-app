import 'package:ecommerce_project/app/features/product/data/models/product-Review-models/review_product_model.dart';
import 'package:ecommerce_project/app/features/product/data/models/product-Review-models/review_user_model.dart';

class ProductReviewModel1 {
  final String id;
  final ReviewProductModel product;
  final ReviewUserModel user;
  final int rating;
  final String comment;


  ProductReviewModel1({
    required this.id,
    required this.product,
    required this.user,
    required this.rating,
    required this.comment,

  });

  factory ProductReviewModel1.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel1(
      id: json['_id'] as String,
      product: ReviewProductModel.fromJson(json['product']),
      user: ReviewUserModel.fromJson(json['user']),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,

    );
  }
}
