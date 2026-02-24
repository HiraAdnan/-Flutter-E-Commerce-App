import 'review_model.dart';

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    required this.sizes,
    required this.colors,
    this.originalPrice,
    this.isFeatured = false,
    this.isNew = false,
    this.reviews = const [],
  });

  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final List<String> sizes;
  final List<String> colors;
  final bool isFeatured;
  final bool isNew;
  final List<Review> reviews;

  double get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;
}
