import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';
import '../../data/services/mock_product_service.dart';

final productServiceProvider = Provider<MockProductService>((ref) {
  return MockProductService();
});

// Search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Category filter
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Sort option
final sortByProvider = StateProvider<String?>((ref) => null);

// Price range
final minPriceProvider = StateProvider<double?>((ref) => null);
final maxPriceProvider = StateProvider<double?>((ref) => null);

// Min rating
final minRatingProvider = StateProvider<double?>((ref) => null);

// Filtered products
final productsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.watch(productServiceProvider);
  final query = ref.watch(searchQueryProvider);
  final category = ref.watch(selectedCategoryProvider);
  final sortBy = ref.watch(sortByProvider);
  final minPrice = ref.watch(minPriceProvider);
  final maxPrice = ref.watch(maxPriceProvider);
  final minRating = ref.watch(minRatingProvider);

  return service.getProducts(
    categoryId: category,
    searchQuery: query,
    sortBy: sortBy,
    minPrice: minPrice,
    maxPrice: maxPrice,
    minRating: minRating,
  );
});

// Featured products
final featuredProductsProvider = FutureProvider<List<Product>>((ref) async {
  final service = ref.watch(productServiceProvider);
  return service.getFeaturedProducts();
});

// Categories
final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final service = ref.watch(productServiceProvider);
  return service.getCategories();
});

// Single product by ID
final productByIdProvider = FutureProvider.family<Product?, String>((ref, id) async {
  final service = ref.watch(productServiceProvider);
  return service.getProductById(id);
});
