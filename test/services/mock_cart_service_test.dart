import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/features/cart/data/services/mock_cart_service.dart';
import 'package:shopease/features/products/data/models/product_model.dart';

Product _makeProduct({String id = 'p1', double price = 50}) {
  return Product(
    id: id,
    name: 'Product $id',
    description: 'Desc',
    price: price,
    imageUrl: 'https://example.com/img.png',
    images: [],
    categoryId: 'cat1',
    rating: 4.0,
    reviewCount: 5,
    sizes: ['S', 'M'],
    colors: ['Red'],
  );
}

void main() {
  late MockCartService service;

  setUp(() {
    service = MockCartService();
  });

  group('MockCartService', () {
    test('starts with empty cart', () {
      expect(service.items, isEmpty);
      expect(service.itemCount, 0);
      expect(service.subtotal, 0);
    });

    group('addItem', () {
      test('adds new product to cart', () {
        service.addItem(_makeProduct());
        expect(service.items.length, 1);
        expect(service.items.first.quantity, 1);
      });

      test('increments quantity for existing product', () {
        final product = _makeProduct();
        service.addItem(product);
        service.addItem(product);
        expect(service.items.length, 1);
        expect(service.items.first.quantity, 2);
      });

      test('treats different sizes as separate items', () {
        final product = _makeProduct();
        service.addItem(product, size: 'S');
        service.addItem(product, size: 'M');
        expect(service.items.length, 2);
      });

      test('treats different colors as separate items', () {
        final product = _makeProduct();
        service.addItem(product, color: 'Red');
        service.addItem(product, color: 'Blue');
        expect(service.items.length, 2);
      });

      test('adds with custom quantity', () {
        service.addItem(_makeProduct(), quantity: 5);
        expect(service.items.first.quantity, 5);
      });
    });

    group('updateQuantity', () {
      test('updates item quantity', () {
        service.addItem(_makeProduct());
        service.updateQuantity(0, 3);
        expect(service.items.first.quantity, 3);
      });

      test('removes item when quantity is 0', () {
        service.addItem(_makeProduct());
        service.updateQuantity(0, 0);
        expect(service.items, isEmpty);
      });

      test('removes item when quantity is negative', () {
        service.addItem(_makeProduct());
        service.updateQuantity(0, -1);
        expect(service.items, isEmpty);
      });

      test('ignores invalid index', () {
        service.addItem(_makeProduct());
        service.updateQuantity(5, 3);
        expect(service.items.first.quantity, 1);
      });
    });

    group('removeItem', () {
      test('removes item at index', () {
        service.addItem(_makeProduct(id: 'p1'));
        service.addItem(_makeProduct(id: 'p2'));
        service.removeItem(0);
        expect(service.items.length, 1);
        expect(service.items.first.product.id, 'p2');
      });

      test('ignores invalid index', () {
        service.addItem(_makeProduct());
        service.removeItem(5);
        expect(service.items.length, 1);
      });
    });

    group('clear', () {
      test('removes all items', () {
        service.addItem(_makeProduct(id: 'p1'));
        service.addItem(_makeProduct(id: 'p2'));
        service.clear();
        expect(service.items, isEmpty);
      });
    });

    group('calculations', () {
      test('subtotal sums item totals', () {
        service.addItem(_makeProduct(price: 30), quantity: 2); // 60
        service.addItem(_makeProduct(id: 'p2', price: 40)); // 40
        expect(service.subtotal, 100);
      });

      test('itemCount sums all quantities', () {
        service.addItem(_makeProduct(), quantity: 3);
        service.addItem(_makeProduct(id: 'p2'), quantity: 2);
        expect(service.itemCount, 5);
      });

      test('shipping is free for orders over 100', () {
        service.addItem(_makeProduct(price: 110));
        expect(service.shipping, 0);
      });

      test('shipping costs 9.99 for orders under 100', () {
        service.addItem(_makeProduct(price: 50));
        expect(service.shipping, 9.99);
      });

      test('tax is 8% of subtotal', () {
        service.addItem(_makeProduct(price: 100));
        expect(service.tax, 8.0);
      });

      test('total is subtotal + shipping + tax', () {
        service.addItem(_makeProduct(price: 50));
        const expected = 50 + 9.99 + (50 * 0.08);
        expect(service.total, expected);
      });
    });
  });
}
