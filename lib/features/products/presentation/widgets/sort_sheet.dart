import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/product_providers.dart';

class SortSheet extends ConsumerWidget {
  const SortSheet({super.key});

  static const _options = [
    (value: null, label: 'Default'),
    (value: 'price_asc', label: 'Price: Low to High'),
    (value: 'price_desc', label: 'Price: High to Low'),
    (value: 'rating', label: 'Highest Rated'),
    (value: 'newest', label: 'Newest First'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(sortByProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sort By',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          ..._options.map((opt) => RadioListTile<String?>(
                title: Text(opt.label),
                value: opt.value,
                groupValue: current,
                onChanged: (v) {
                  ref.read(sortByProvider.notifier).state = v;
                  Navigator.pop(context);
                },
              )),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
