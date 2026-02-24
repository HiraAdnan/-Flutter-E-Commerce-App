import '../models/order_model.dart';
import '../models/address_model.dart';
import '../../../cart/data/models/cart_item_model.dart';
import '../../../../core/constants/app_constants.dart';

class MockOrderService {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  Future<Order> placeOrder({
    required List<CartItem> items,
    required Address address,
    required double subtotal,
    required double shipping,
    required double tax,
    required double total,
    String paymentMethod = 'Credit Card',
  }) async {
    await Future.delayed(AppConstants.mockNetworkDelay);

    final order = Order(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      items: List.from(items),
      address: address,
      status: OrderStatus.placed,
      subtotal: subtotal,
      shipping: shipping,
      tax: tax,
      total: total,
      placedAt: DateTime.now(),
      paymentMethod: paymentMethod,
    );

    _orders.insert(0, order);
    return order;
  }

  Future<List<Order>> getOrders() async {
    await Future.delayed(AppConstants.mockNetworkDelay);
    return _orders;
  }

  Future<Order?> getOrderById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _orders.firstWhere((o) => o.id == id);
    } catch (_) {
      return null;
    }
  }
}
