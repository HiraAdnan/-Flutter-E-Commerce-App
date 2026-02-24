import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class PriceSummary extends StatelessWidget {
  const PriceSummary({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        children: [
          _Row(label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _Row(
            label: 'Shipping',
            value: shipping == 0 ? 'Free' : '\$${shipping.toStringAsFixed(2)}',
            valueColor: shipping == 0 ? Colors.green : null,
          ),
          const SizedBox(height: 8),
          _Row(label: 'Tax', value: '\$${tax.toStringAsFixed(2)}'),
          const Divider(height: 24),
          _Row(
            label: 'Total',
            value: '\$${total.toStringAsFixed(2)}',
            isBold: true,
            valueColor: colorScheme.primary,
          ),
          if (subtotal > 0 && subtotal < 100) ...[
            const SizedBox(height: 8),
            Text(
              'Add \$${(100 - subtotal).toStringAsFixed(2)} more for free shipping!',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.value,
    this.isBold = false,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool isBold;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final style = isBold
        ? Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyMedium;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style?.copyWith(color: valueColor)),
      ],
    );
  }
}
