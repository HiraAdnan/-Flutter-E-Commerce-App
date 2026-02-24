import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/checkout_provider.dart';

class PaymentMethodSelector extends ConsumerWidget {
  const PaymentMethodSelector({super.key});

  static const _methods = [
    ('Credit Card', Icons.credit_card),
    ('PayPal', Icons.account_balance_wallet),
    ('Apple Pay', Icons.phone_iphone),
    ('Google Pay', Icons.g_mobiledata),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedPaymentMethodProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment Method',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        const SizedBox(height: AppConstants.spacingSm),
        ..._methods.map((m) {
          final isSelected = selected == m.$1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(m.$2),
              title: Text(m.$1),
              trailing: isSelected ? const Icon(Icons.check_circle, color: Colors.green) : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outlineVariant,
                  width: isSelected ? 2 : 1,
                ),
              ),
              onTap: () {
                ref.read(selectedPaymentMethodProvider.notifier).state = m.$1;
              },
            ),
          );
        }),
      ],
    );
  }
}
