class ReviewUserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  ReviewUserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      id: json['_id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      avatarUrl: json['avatar_url'],
    );
  }
}
