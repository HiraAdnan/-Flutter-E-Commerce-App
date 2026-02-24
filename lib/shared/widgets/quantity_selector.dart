import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
  });

  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _RoundButton(
          icon: Icons.remove,
          onPressed: quantity > min ? () => onChanged(quantity - 1) : null,
          colorScheme: colorScheme,
        ),
        SizedBox(
          width: 40,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        _RoundButton(
          icon: Icons.add,
          onPressed: quantity < max ? () => onChanged(quantity + 1) : null,
          colorScheme: colorScheme,
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.onPressed,
    required this.colorScheme,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: IconButton.outlined(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon),
        onPressed: onPressed,
        style: IconButton.styleFrom(
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
    );
  }
}
