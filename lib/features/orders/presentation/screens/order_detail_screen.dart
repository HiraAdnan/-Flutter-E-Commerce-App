import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../checkout/presentation/providers/checkout_provider.dart';
import '../widgets/order_status_stepper.dart';

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderByIdProvider(orderId));

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: orderAsync.when(
        data: (order) {
          if (order == null) {
            return const Center(child: Text('Order not found'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID and date
                Text(order.id,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                Text(
                  'Placed on ${DateFormat.yMMMMd().format(order.placedAt)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: AppConstants.spacingLg),

                // Status stepper
                OrderStatusStepper(status: order.status),
                const Divider(height: 32),

                // Items
                Text('Items', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 8),
                ...order.items.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('${item.product.name} x${item.quantity}'),
                          ),
                          Text('\$${item.total.toStringAsFixed(2)}'),
                        ],
                      ),
                    )),
                const Divider(height: 24),

                // Price breakdown
                _PriceRow('Subtotal', '\$${order.subtotal.toStringAsFixed(2)}'),
                _PriceRow('Shipping', order.shipping == 0 ? 'Free' : '\$${order.shipping.toStringAsFixed(2)}'),
                _PriceRow('Tax', '\$${order.tax.toStringAsFixed(2)}'),
                const Divider(height: 16),
                _PriceRow('Total', '\$${order.total.toStringAsFixed(2)}', bold: true),
                const SizedBox(height: AppConstants.spacingLg),

                // Shipping address
                Text('Shipping Address', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 8),
                Text(order.address.fullName),
                Text(order.address.formatted),
                const SizedBox(height: AppConstants.spacingMd),

                // Payment method
                Text('Payment', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 8),
                Text(order.paymentMethod),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow(this.label, this.value, {this.bold = false});
  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label, style: style), Text(value, style: style)],
      ),
    );
  }
}
