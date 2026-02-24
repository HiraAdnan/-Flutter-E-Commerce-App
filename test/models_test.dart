import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/features/products/data/models/product_model.dart';
import 'package:shopease/features/products/data/models/category_model.dart';
import 'package:shopease/features/products/data/models/review_model.dart';
import 'package:shopease/features/auth/data/models/user_model.dart';
import 'package:shopease/features/cart/data/models/cart_item_model.dart';
import 'package:shopease/features/checkout/data/models/address_model.dart';
import 'package:shopease/features/checkout/data/models/order_model.dart';

Product _makeProduct({
  double price = 100,
  double? originalPrice,
  bool isFeatured = false,
  bool isNew = false,
}) {
  return Product(
    id: 'p1',
    name: 'Test Product',
    description: 'A test product',
    price: price,
    originalPrice: originalPrice,
    imageUrl: 'https://example.com/img.png',
    images: ['https://example.com/img1.png'],
    categoryId: 'cat1',
    rating: 4.5,
    reviewCount: 10,
    sizes: ['S', 'M', 'L'],
    colors: ['Red', 'Blue'],
    isFeatured: isFeatured,
    isNew: isNew,
  );
}

void main() {
  group('Product', () {
    test('hasDiscount returns true when originalPrice > price', () {
      final product = _makeProduct(price: 80, originalPrice: 100);
      expect(product.hasDiscount, isTrue);
    });

    test('hasDiscount returns false when originalPrice is null', () {
      final product = _makeProduct(price: 80);
      expect(product.hasDiscount, isFalse);
    });

    test('hasDiscount returns false when originalPrice <= price', () {
      final product = _makeProduct(price: 100, originalPrice: 100);
      expect(product.hasDiscount, isFalse);
    });

    test('discountPercentage calculates correctly', () {
      final product = _makeProduct(price: 75, originalPrice: 100);
      expect(product.discountPercentage, 25.0);
    });

    test('discountPercentage is 0 when no discount', () {
      final product = _makeProduct(price: 100);
      expect(product.discountPercentage, 0);
    });

    test('stores all fields correctly', () {
      final product = _makeProduct(isFeatured: true, isNew: true);
      expect(product.id, 'p1');
      expect(product.name, 'Test Product');
      expect(product.sizes, ['S', 'M', 'L']);
      expect(product.colors, ['Red', 'Blue']);
      expect(product.isFeatured, isTrue);
      expect(product.isNew, isTrue);
    });
  });

  group('Category', () {
    test('stores all fields correctly', () {
      const cat = Category(
        id: 'c1',
        name: 'Electronics',
        icon: '📱',
        imageUrl: 'https://example.com/cat.png',
      );
      expect(cat.id, 'c1');
      expect(cat.name, 'Electronics');
      expect(cat.icon, '📱');
    });
  });

  group('Review', () {
    test('stores all fields correctly', () {
      final review = Review(
        id: 'r1',
        userId: 'u1',
        userName: 'John',
        rating: 4.5,
        comment: 'Great product',
        date: DateTime(2026, 1, 15),
      );
      expect(review.rating, 4.5);
      expect(review.userName, 'John');
      expect(review.date, DateTime(2026, 1, 15));
    });
  });

  group('AppUser', () {
    test('stores required fields', () {
      const user = AppUser(id: 'u1', name: 'Jane', email: 'jane@test.com');
      expect(user.id, 'u1');
      expect(user.name, 'Jane');
      expect(user.email, 'jane@test.com');
      expect(user.avatarUrl, isNull);
      expect(user.phone, isNull);
    });

    test('stores optional fields', () {
      const user = AppUser(
        id: 'u1',
        name: 'Jane',
        email: 'jane@test.com',
        avatarUrl: 'https://example.com/avatar.png',
        phone: '+1234567890',
      );
      expect(user.avatarUrl, isNotNull);
      expect(user.phone, '+1234567890');
    });
  });

  group('CartItem', () {
    test('total equals price * quantity', () {
      final product = _makeProduct(price: 25);
      final item = CartItem(product: product, quantity: 3);
      expect(item.total, 75);
    });

    test('copyWith updates quantity', () {
      final product = _makeProduct(price: 50);
      final item = CartItem(product: product, quantity: 1);
      final updated = item.copyWith(quantity: 5);
      expect(updated.quantity, 5);
      expect(updated.product.id, item.product.id);
    });

    test('copyWith updates selectedSize', () {
      final product = _makeProduct();
      final item = CartItem(product: product, quantity: 1, selectedSize: 'S');
      final updated = item.copyWith(selectedSize: 'L');
      expect(updated.selectedSize, 'L');
    });

    test('copyWith retains unchanged fields', () {
      final product = _makeProduct();
      final item = CartItem(
        product: product,
        quantity: 2,
        selectedSize: 'M',
        selectedColor: 'Red',
      );
      final updated = item.copyWith(quantity: 4);
      expect(updated.selectedSize, 'M');
      expect(updated.selectedColor, 'Red');
    });
  });

  group('Address', () {
    test('formatted returns full address string', () {
      const address = Address(
        fullName: 'John Doe',
        street: '123 Main St',
        city: 'Anytown',
        state: 'CA',
        zipCode: '12345',
        country: 'US',
      );
      expect(address.formatted, '123 Main St, Anytown, CA 12345, US');
    });

    test('phone is optional', () {
      const address = Address(
        fullName: 'Jane',
        street: '456 Oak Ave',
        city: 'Springfield',
        state: 'IL',
        zipCode: '62701',
        country: 'US',
      );
      expect(address.phone, isNull);
    });
  });

  group('Order', () {
    test('stores all required fields', () {
      final order = Order(
        id: 'ORD-001',
        items: [],
        address: const Address(
          fullName: 'Test',
          street: '1 St',
          city: 'City',
          state: 'ST',
          zipCode: '00000',
          country: 'US',
        ),
        status: OrderStatus.placed,
        subtotal: 100,
        shipping: 10,
        tax: 8,
        total: 118,
        placedAt: DateTime(2026, 2, 18),
      );
      expect(order.id, 'ORD-001');
      expect(order.status, OrderStatus.placed);
      expect(order.total, 118);
      expect(order.paymentMethod, 'Credit Card');
    });

    test('OrderStatus has all expected values', () {
      expect(OrderStatus.values, containsAll([
        OrderStatus.placed,
        OrderStatus.processing,
        OrderStatus.shipped,
        OrderStatus.delivered,
        OrderStatus.cancelled,
      ]));
    });
  });
}
