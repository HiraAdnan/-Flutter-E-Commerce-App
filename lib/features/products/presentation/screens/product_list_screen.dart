import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/app_search_bar.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/sort_sheet.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(productsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const SortSheet(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            tooltip: 'Filter',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => const FilterBottomSheet(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: AppSearchBar(
              onSearch: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
              },
            ),
          ),
          if (selectedCategory != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacingMd),
              child: Row(
                children: [
                  Chip(
                    label: Text(selectedCategory),
                    onDeleted: () {
                      ref.read(selectedCategoryProvider.notifier).state = null;
                    },
                  ),
                ],
              ),
            ),
          Expanded(
            child: productsAsync.when(
              data: (products) {
                if (products.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off,
                    title: 'No products found',
                    subtitle: 'Try adjusting your search or filters.',
                    actionLabel: 'Clear Filters',
                    onAction: () {
                      ref.read(searchQueryProvider.notifier).state = '';
                      ref.read(selectedCategoryProvider.notifier).state = null;
                      ref.read(minPriceProvider.notifier).state = null;
                      ref.read(maxPriceProvider.notifier).state = null;
                      ref.read(minRatingProvider.notifier).state = null;
                    },
                  );
                }
                return GridView.builder(
                  padding: const EdgeInsets.all(AppConstants.spacingMd),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: AppConstants.spacingSm,
                    mainAxisSpacing: AppConstants.spacingSm,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) =>
                      ProductCard(product: products[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
