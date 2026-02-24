import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/product_providers.dart';

class FilterBottomSheet extends ConsumerStatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  ConsumerState<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends ConsumerState<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(0, 500);
  double _minRating = 0;

  @override
  void initState() {
    super.initState();
    final minP = ref.read(minPriceProvider);
    final maxP = ref.read(maxPriceProvider);
    final minR = ref.read(minRatingProvider);
    _priceRange = RangeValues(minP ?? 0, maxP ?? 500);
    _minRating = minR ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: ListView(
            controller: scrollController,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingMd),
              Text('Filters', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              )),
              const SizedBox(height: AppConstants.spacingLg),

              // Price range
              Text('Price Range', style: Theme.of(context).textTheme.titleSmall),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 500,
                divisions: 50,
                labels: RangeLabels(
                  '\$${_priceRange.start.toInt()}',
                  '\$${_priceRange.end.toInt()}',
                ),
                onChanged: (v) => setState(() => _priceRange = v),
              ),
              Text(
                '\$${_priceRange.start.toInt()} - \$${_priceRange.end.toInt()}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.spacingLg),

              // Min rating
              Text('Minimum Rating', style: Theme.of(context).textTheme.titleSmall),
              Slider(
                value: _minRating,
                min: 0,
                max: 5,
                divisions: 10,
                label: _minRating == 0 ? 'Any' : '${_minRating.toStringAsFixed(1)}+',
                onChanged: (v) => setState(() => _minRating = v),
              ),
              const SizedBox(height: AppConstants.spacingXl),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        ref.read(minPriceProvider.notifier).state = null;
                        ref.read(maxPriceProvider.notifier).state = null;
                        ref.read(minRatingProvider.notifier).state = null;
                        Navigator.pop(context);
                      },
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ref.read(minPriceProvider.notifier).state =
                            _priceRange.start > 0 ? _priceRange.start : null;
                        ref.read(maxPriceProvider.notifier).state =
                            _priceRange.end < 500 ? _priceRange.end : null;
                        ref.read(minRatingProvider.notifier).state =
                            _minRating > 0 ? _minRating : null;
                        Navigator.pop(context);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
