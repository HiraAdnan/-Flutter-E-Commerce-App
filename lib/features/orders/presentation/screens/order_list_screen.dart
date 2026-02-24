import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../checkout/presentation/providers/checkout_provider.dart';

class OrderListScreen extends ConsumerWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No orders yet',
              subtitle: 'Your order history will appear here.',
              actionLabel: 'Start Shopping',
              onAction: () => context.go('/home'),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(
                    order.id,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        '${order.items.length} item(s) - \$${order.total.toStringAsFixed(2)}',
                      ),
                      Text(
                        DateFormat.yMMMd().format(order.placedAt),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  trailing: Chip(
                    label: Text(
                      order.status.name.toUpperCase(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ),
                  onTap: () => context.push('/order/${order.id}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
