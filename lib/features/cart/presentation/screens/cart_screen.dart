import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/price_summary.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    if (cart.items.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Cart')),
        body: EmptyState(
          icon: Icons.shopping_cart_outlined,
          title: 'Your cart is empty',
          subtitle: 'Add some items to get started.',
          actionLabel: 'Browse Products',
          onAction: () => context.go('/products'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${cart.itemCount})'),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Clear Cart'),
                  content: const Text('Remove all items from your cart?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).clear();
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                return CartItemTile(
                  item: cart.items[index],
                  index: index,
                  onQuantityChanged: (i, q) {
                    ref.read(cartProvider.notifier).updateQuantity(i, q);
                  },
                  onRemove: (i) {
                    ref.read(cartProvider.notifier).removeItem(i);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Column(
              children: [
                PriceSummary(
                  subtotal: cart.subtotal,
                  shipping: cart.shipping,
                  tax: cart.tax,
                  total: cart.total,
                ),
                const SizedBox(height: AppConstants.spacingMd),
                SafeArea(
                  child: FilledButton(
                    onPressed: () => context.push('/checkout'),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
