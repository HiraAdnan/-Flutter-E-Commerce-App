import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/order_model.dart';
import '../../data/models/address_model.dart';
import '../../data/services/mock_order_service.dart';
import '../../../cart/presentation/providers/cart_provider.dart';

final orderServiceProvider = Provider<MockOrderService>((ref) {
  return MockOrderService();
});

final selectedPaymentMethodProvider = StateProvider<String>((ref) => 'Credit Card');

final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier(
    ref.watch(orderServiceProvider),
    ref,
  );
});

class CheckoutState {
  const CheckoutState({this.isLoading = false, this.error, this.lastOrder});
  final bool isLoading;
  final String? error;
  final Order? lastOrder;
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier(this._service, this._ref) : super(const CheckoutState());
  final MockOrderService _service;
  final Ref _ref;

  Future<Order?> placeOrder(Address address) async {
    state = const CheckoutState(isLoading: true);
    try {
      final cart = _ref.read(cartProvider);
      final paymentMethod = _ref.read(selectedPaymentMethodProvider);

      final order = await _service.placeOrder(
        items: cart.items,
        address: address,
        subtotal: cart.subtotal,
        shipping: cart.shipping,
        tax: cart.tax,
        total: cart.total,
        paymentMethod: paymentMethod,
      );

      _ref.read(cartProvider.notifier).clear();
      state = CheckoutState(lastOrder: order);
      return order;
    } catch (e) {
      state = CheckoutState(error: e.toString());
      return null;
    }
  }
}

// Order history
final ordersProvider = FutureProvider<List<Order>>((ref) async {
  final service = ref.watch(orderServiceProvider);
  return service.getOrders();
});

final orderByIdProvider = FutureProvider.family<Order?, String>((ref, id) async {
  final service = ref.watch(orderServiceProvider);
  return service.getOrderById(id);
});
