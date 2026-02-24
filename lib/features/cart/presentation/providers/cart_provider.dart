import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/services/mock_cart_service.dart';
import '../../../products/data/models/product_model.dart';

final cartServiceProvider = Provider<MockCartService>((ref) {
  return MockCartService();
});

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier(ref.watch(cartServiceProvider));
});

class CartState {
  const CartState({
    this.items = const [],
    this.subtotal = 0,
    this.shipping = 0,
    this.tax = 0,
    this.total = 0,
  });

  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier(this._service) : super(const CartState());
  final MockCartService _service;

  void addItem(Product product, {int quantity = 1, String? size, String? color}) {
    _service.addItem(product, quantity: quantity, size: size, color: color);
    _updateState();
  }

  void updateQuantity(int index, int quantity) {
    _service.updateQuantity(index, quantity);
    _updateState();
  }

  void removeItem(int index) {
    _service.removeItem(index);
    _updateState();
  }

  void clear() {
    _service.clear();
    _updateState();
  }

  void _updateState() {
    state = CartState(
      items: _service.items,
      subtotal: _service.subtotal,
      shipping: _service.shipping,
      tax: _service.tax,
      total: _service.total,
    );
  }
}
