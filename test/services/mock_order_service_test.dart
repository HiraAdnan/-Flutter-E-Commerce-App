import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/features/checkout/data/services/mock_order_service.dart';
import 'package:shopease/features/checkout/data/models/order_model.dart';
import 'package:shopease/features/checkout/data/models/address_model.dart';
import 'package:shopease/features/cart/data/models/cart_item_model.dart';
import 'package:shopease/features/products/data/models/product_model.dart';

const _testAddress = Address(
  fullName: 'Test User',
  street: '123 Test St',
  city: 'Testville',
  state: 'TS',
  zipCode: '12345',
  country: 'US',
);

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
    sizes: [],
    colors: [],
  );
}

void main() {
  late MockOrderService service;

  setUp(() {
    service = MockOrderService();
  });

  group('MockOrderService', () {
    group('placeOrder', () {
      test('creates order with correct fields', () async {
        final items = [CartItem(product: _makeProduct(), quantity: 2)];
        final order = await service.placeOrder(
          items: items,
          address: _testAddress,
          subtotal: 100,
          shipping: 10,
          tax: 8,
          total: 118,
        );

        expect(order.id, startsWith('ORD-'));
        expect(order.items.length, 1);
        expect(order.address.fullName, 'Test User');
        expect(order.status, OrderStatus.placed);
        expect(order.subtotal, 100);
        expect(order.shipping, 10);
        expect(order.tax, 8);
        expect(order.total, 118);
        expect(order.paymentMethod, 'Credit Card');
      });

      test('adds order to orders list', () async {
        expect(service.orders, isEmpty);
        await service.placeOrder(
          items: [CartItem(product: _makeProduct(), quantity: 1)],
          address: _testAddress,
          subtotal: 50,
          shipping: 10,
          tax: 4,
          total: 64,
        );
        expect(service.orders.length, 1);
      });

      test('newest order appears first', () async {
        await service.placeOrder(
          items: [CartItem(product: _makeProduct(), quantity: 1)],
          address: _testAddress,
          subtotal: 50,
          shipping: 10,
          tax: 4,
          total: 64,
        );
        final secondOrder = await service.placeOrder(
          items: [CartItem(product: _makeProduct(id: 'p2'), quantity: 1)],
          address: _testAddress,
          subtotal: 80,
          shipping: 10,
          tax: 6.4,
          total: 96.4,
        );
        expect(service.orders.first.id, secondOrder.id);
      });

      test('accepts custom payment method', () async {
        final order = await service.placeOrder(
          items: [CartItem(product: _makeProduct(), quantity: 1)],
          address: _testAddress,
          subtotal: 50,
          shipping: 10,
          tax: 4,
          total: 64,
          paymentMethod: 'PayPal',
        );
        expect(order.paymentMethod, 'PayPal');
      });
    });

    group('getOrders', () {
      test('returns all placed orders', () async {
        await service.placeOrder(
          items: [CartItem(product: _makeProduct(), quantity: 1)],
          address: _testAddress,
          subtotal: 50,
          shipping: 10,
          tax: 4,
          total: 64,
        );
        final orders = await service.getOrders();
        expect(orders.length, 1);
      });
    });

    group('getOrderById', () {
      test('returns order for valid id', () async {
        final placed = await service.placeOrder(
          items: [CartItem(product: _makeProduct(), quantity: 1)],
          address: _testAddress,
          subtotal: 50,
          shipping: 10,
          tax: 4,
          total: 64,
        );
        final found = await service.getOrderById(placed.id);
        expect(found, isNotNull);
        expect(found!.id, placed.id);
      });

      test('returns null for invalid id', () async {
        final found = await service.getOrderById('nonexistent');
        expect(found, isNull);
      });
    });
  });
}
