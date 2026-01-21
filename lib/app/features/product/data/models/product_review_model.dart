
// "_id": "696b81291d252c0ba332ffe4",
// "first_name": "anower",
// "last_name": "siyam",
// "comment": "nice book",
class ProductReviewModel {
  final String id;
  final String firstname;
  final String lastname;
  final String comment;

  ProductReviewModel({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.comment});

  factory ProductReviewModel.fromJson(Map<String, dynamic> json){
    return ProductReviewModel(id: json['_id'],
      firstname: json['first_name']?.toString() ?? '',
      lastname: json['last_name']?.toString() ?? '',
      comment: json['comment']?.toString() ?? '',
    );
  }
}