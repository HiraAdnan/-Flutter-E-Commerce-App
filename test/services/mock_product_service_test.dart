import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/features/products/data/services/mock_product_service.dart';

void main() {
  late MockProductService service;

  setUp(() {
    service = MockProductService();
  });

  group('MockProductService', () {
    group('getProducts', () {
      test('returns all products when no filters', () async {
        final products = await service.getProducts();
        expect(products.length, MockProductService.products.length);
      });

      test('filters by category', () async {
        final products = await service.getProducts(categoryId: 'electronics');
        expect(products, isNotEmpty);
        expect(products.every((p) => p.categoryId == 'electronics'), isTrue);
      });

      test('filters by search query (name)', () async {
        final products = await service.getProducts(searchQuery: 'headphones');
        expect(products, isNotEmpty);
        expect(
          products.every((p) =>
              p.name.toLowerCase().contains('headphones') ||
              p.description.toLowerCase().contains('headphones')),
          isTrue,
        );
      });

      test('filters by minimum price', () async {
        final products = await service.getProducts(minPrice: 100);
        expect(products, isNotEmpty);
        expect(products.every((p) => p.price >= 100), isTrue);
      });

      test('filters by maximum price', () async {
        final products = await service.getProducts(maxPrice: 60.0);
        expect(products, isNotEmpty);
        expect(products.every((p) => p.price <= 60.0), isTrue);
      });

      test('filters by minimum rating', () async {
        final products = await service.getProducts(minRating: 4.6);
        expect(products, isNotEmpty);
        expect(products.every((p) => p.rating >= 4.6), isTrue);
      });

      test('sorts by price ascending', () async {
        final products = await service.getProducts(sortBy: 'price_asc');
        for (int i = 0; i < products.length - 1; i++) {
          expect(products[i].price, lessThanOrEqualTo(products[i + 1].price));
        }
      });

      test('sorts by price descending', () async {
        final products = await service.getProducts(sortBy: 'price_desc');
        for (int i = 0; i < products.length - 1; i++) {
          expect(products[i].price, greaterThanOrEqualTo(products[i + 1].price));
        }
      });

      test('sorts by rating', () async {
        final products = await service.getProducts(sortBy: 'rating');
        for (int i = 0; i < products.length - 1; i++) {
          expect(products[i].rating, greaterThanOrEqualTo(products[i + 1].rating));
        }
      });

      test('returns empty list for non-matching search', () async {
        final products = await service.getProducts(searchQuery: 'xyznonexistent');
        expect(products, isEmpty);
      });

      test('combines filters', () async {
        final products = await service.getProducts(
          categoryId: 'electronics',
          minPrice: 50,
          maxPrice: 300,
        );
        expect(products, isNotEmpty);
        for (final p in products) {
          expect(p.categoryId, 'electronics');
          expect(p.price, greaterThanOrEqualTo(50));
          expect(p.price, lessThanOrEqualTo(300));
        }
      });
    });

    group('getProductById', () {
      test('returns product for valid id', () async {
        final product = await service.getProductById('e1');
        expect(product, isNotNull);
        expect(product!.id, 'e1');
      });

      test('returns null for invalid id', () async {
        final product = await service.getProductById('nonexistent');
        expect(product, isNull);
      });
    });

    group('getFeaturedProducts', () {
      test('returns only featured products', () async {
        final products = await service.getFeaturedProducts();
        expect(products, isNotEmpty);
        expect(products.every((p) => p.isFeatured), isTrue);
      });
    });

    group('getCategories', () {
      test('returns all 6 categories', () async {
        final categories = await service.getCategories();
        expect(categories.length, 6);
      });

      test('each category has required fields', () async {
        final categories = await service.getCategories();
        for (final cat in categories) {
          expect(cat.id, isNotEmpty);
          expect(cat.name, isNotEmpty);
          expect(cat.icon, isNotEmpty);
          expect(cat.imageUrl, isNotEmpty);
        }
      });
    });

    group('mock data integrity', () {
      test('has products in every category', () {
        final categoryIds = MockProductService.categories.map((c) => c.id).toSet();
        for (final catId in categoryIds) {
          final productsInCategory =
              MockProductService.products.where((p) => p.categoryId == catId);
          expect(productsInCategory, isNotEmpty,
              reason: 'Category $catId should have at least one product');
        }
      });

      test('has at least 19 products', () {
        expect(MockProductService.products.length, greaterThanOrEqualTo(19));
      });

      test('all products have valid ratings between 1 and 5', () {
        for (final p in MockProductService.products) {
          expect(p.rating, greaterThanOrEqualTo(1));
          expect(p.rating, lessThanOrEqualTo(5));
        }
      });
    });
  });
}
