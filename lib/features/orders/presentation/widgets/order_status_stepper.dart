import 'package:flutter/material.dart';
import '../../../checkout/data/models/order_model.dart';

class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({super.key, required this.status});
  final OrderStatus status;

  static const _steps = [
    (OrderStatus.placed, 'Placed', Icons.receipt_long),
    (OrderStatus.processing, 'Processing', Icons.inventory_2),
    (OrderStatus.shipped, 'Shipped', Icons.local_shipping),
    (OrderStatus.delivered, 'Delivered', Icons.check_circle),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentIndex = _steps.indexWhere((s) => s.$1 == status);

    return Row(
      children: List.generate(_steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          // Connector line
          final stepIndex = i ~/ 2;
          final isActive = stepIndex < currentIndex;
          return Expanded(
            child: Container(
              height: 2,
              color: isActive ? colorScheme.primary : colorScheme.outlineVariant,
            ),
          );
        }

        final stepIndex = i ~/ 2;
        final step = _steps[stepIndex];
        final isActive = stepIndex <= currentIndex;
        final isCurrent = stepIndex == currentIndex;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? colorScheme.primary : colorScheme.surfaceContainerHighest,
                border: isCurrent
                    ? Border.all(color: colorScheme.primary, width: 2)
                    : null,
              ),
              child: Icon(
                step.$3,
                size: 20,
                color: isActive ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              step.$2,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        );
      }),
    );
  }
}
