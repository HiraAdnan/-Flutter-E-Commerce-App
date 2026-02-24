import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/widgets/price_summary.dart';
import '../providers/checkout_provider.dart';
import '../widgets/address_form.dart';
import '../widgets/payment_method_selector.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _addressFormKey = GlobalKey<AddressFormState>();

  Future<void> _placeOrder() async {
    final formState = _addressFormKey.currentState;
    if (formState == null || !formState.validate()) return;

    final address = formState.getAddress();
    final order = await ref.read(checkoutProvider.notifier).placeOrder(address);
    if (order != null && mounted) {
      context.go('/order-confirmation/${order.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final checkout = ref.watch(checkoutProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddressForm(
              key: _addressFormKey,
              onSubmit: (_) {},
            ),
            const SizedBox(height: AppConstants.spacingLg),
            const PaymentMethodSelector(),
            const SizedBox(height: AppConstants.spacingLg),
            Text('Order Summary',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: AppConstants.spacingSm),
            ...cart.items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${item.product.name} x${item.quantity}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text('\$${item.total.toStringAsFixed(2)}'),
                    ],
                  ),
                )),
            const SizedBox(height: AppConstants.spacingMd),
            PriceSummary(
              subtotal: cart.subtotal,
              shipping: cart.shipping,
              tax: cart.tax,
              total: cart.total,
            ),
            const SizedBox(height: AppConstants.spacingLg),
            if (checkout.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  checkout.error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
            FilledButton(
              onPressed: checkout.isLoading ? null : _placeOrder,
              child: checkout.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('Place Order - \$${cart.total.toStringAsFixed(2)}'),
            ),
            const SizedBox(height: AppConstants.spacingXl),
          ],
        ),
      ),
    );
  }
}
