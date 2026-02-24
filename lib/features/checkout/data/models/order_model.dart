import '../../../cart/data/models/cart_item_model.dart';
import 'address_model.dart';

enum OrderStatus { placed, processing, shipped, delivered, cancelled }

class Order {
  const Order({
    required this.id,
    required this.items,
    required this.address,
    required this.status,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
    required this.placedAt,
    this.paymentMethod = 'Credit Card',
  });

  final String id;
  final List<CartItem> items;
  final Address address;
  final OrderStatus status;
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;
  final DateTime placedAt;
  final String paymentMethod;
}
