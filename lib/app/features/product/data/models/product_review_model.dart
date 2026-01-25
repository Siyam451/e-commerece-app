class ProductReviewModel {
  final String id;
  final ReviewProduct product;
  final ReviewUser user;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductReviewModel({
    required this.id,
    required this.product,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      id: json['_id'],
      product: ReviewProduct.fromJson(json['product']),
      user: ReviewUser.fromJson(json['user']),
      rating: json['rating'],
      comment: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ReviewProduct {
  final String id;
  final String title;
  final String slug;
  final List<String> photos;

  ReviewProduct({
    required this.id,
    required this.title,
    required this.slug,
    required this.photos,
  });

  factory ReviewProduct.fromJson(Map<String, dynamic> json) {
    return ReviewProduct(
      id: json['_id'],
      title: json['title'],
      slug: json['slug'],
      photos: List<String>.from(json['photos']),
    );
  }
}

class ReviewUser {
  final String id;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  ReviewUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar_url'],
    );
  }
}
