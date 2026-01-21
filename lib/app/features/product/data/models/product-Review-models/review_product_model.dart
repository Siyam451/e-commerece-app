class ReviewProductModel {
  final String id;
  final String title;
  final String slug;
  final List<String> photos;

  ReviewProductModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.photos,
  });

  factory ReviewProductModel.fromJson(Map<String, dynamic> json) {
    return ReviewProductModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      photos: List<String>.from(json['photos'] ?? []),
    );
  }
}
