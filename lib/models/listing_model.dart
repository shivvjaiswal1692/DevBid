class ListingModel {
  ListingModel({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.description,
    this.imageUrl,
    this.createdAt,
  });

  final String id;
  final String title;
  final String category;
  final double price;
  final String description;
  final String? imageUrl;
  final DateTime? createdAt;
}
