import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/quantity_selector.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../providers/product_providers.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _quantity = 1;
  int _selectedImageIndex = 0;
  String? _selectedSize;
  String? _selectedColor;

  @override
  Widget build(BuildContext context) {
    final productAsync = ref.watch(productByIdProvider(widget.productId));
    final colorScheme = Theme.of(context).colorScheme;

    return productAsync.when(
      data: (product) {
        if (product == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Product not found')),
          );
        }

        final allImages = [product.imageUrl, ...product.images];

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // Image gallery
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: 'product_${product.id}',
                        child: CachedNetworkImage(
                          imageUrl: allImages[_selectedImageIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Image thumbnails
                      if (allImages.length > 1)
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(allImages.length, (i) {
                              return GestureDetector(
                                onTap: () => setState(() => _selectedImageIndex = i),
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: i == _selectedImageIndex
                                          ? colorScheme.primary
                                          : Colors.white54,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: CachedNetworkImage(
                                      imageUrl: allImages[i],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.spacingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title & price
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.primary,
                                ),
                          ),
                          if (product.hasDiscount) ...[
                            const SizedBox(width: 8),
                            Text(
                              '\$${product.originalPrice!.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '-${product.discountPercentage.toInt()}%',
                                style: TextStyle(
                                  color: colorScheme.onErrorContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Row(
                        children: [
                          ...List.generate(5, (i) {
                            return Icon(
                              i < product.rating.floor()
                                  ? Icons.star
                                  : (i < product.rating ? Icons.star_half : Icons.star_border),
                              size: 20,
                              color: AppColors.ratingStar,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            '${product.rating} (${product.reviewCount} reviews)',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),

                      // Description
                      Text('Description', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      )),
                      const SizedBox(height: 8),
                      Text(product.description, style: Theme.of(context).textTheme.bodyLarge),
                      const Divider(height: 32),

                      // Size selector
                      if (product.sizes.isNotEmpty) ...[
                        Text('Size', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: product.sizes.map((size) {
                            final selected = _selectedSize == size;
                            return ChoiceChip(
                              label: Text(size),
                              selected: selected,
                              onSelected: (_) => setState(() => _selectedSize = size),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Color selector
                      if (product.colors.isNotEmpty) ...[
                        Text('Color', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: product.colors.map((color) {
                            final selected = _selectedColor == color;
                            return ChoiceChip(
                              label: Text(color),
                              selected: selected,
                              onSelected: (_) => setState(() => _selectedColor = color),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Quantity
                      Row(
                        children: [
                          Text('Quantity', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                          const SizedBox(width: 16),
                          QuantitySelector(
                            quantity: _quantity,
                            onChanged: (v) => setState(() => _quantity = v),
                          ),
                        ],
                      ),
                      const Divider(height: 32),

                      // Reviews
                      Text(
                        'Reviews (${product.reviews.length})',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...product.reviews.map((review) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(review.userName,
                                        style: const TextStyle(fontWeight: FontWeight.bold)),
                                    const Spacer(),
                                    ...List.generate(5, (i) => Icon(
                                          i < review.rating ? Icons.star : Icons.star_border,
                                          size: 14,
                                          color: AppColors.ratingStar,
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(review.comment),
                              ],
                            ),
                          )),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Container(
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
            ),
            child: SafeArea(
              child: FilledButton.icon(
                onPressed: () {
                  ref.read(cartProvider.notifier).addItem(
                        product,
                        quantity: _quantity,
                        size: _selectedSize,
                        color: _selectedColor,
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart'),
                      action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                label: Text('Add to Cart - \$${(product.price * _quantity).toStringAsFixed(2)}'),
              ),
            ),
          ),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}
