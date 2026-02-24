import '../models/category_model.dart';
import '../models/product_model.dart';
import '../models/review_model.dart';
import '../../../../core/constants/app_constants.dart';

class MockProductService {
  static const _img = 'https://cdn.dummyjson.com/product-images';

  static final List<Category> categories = [
    const Category(
      id: 'electronics',
      name: 'Electronics',
      icon: '📱',
      imageUrl: '$_img/mobile-accessories/apple-airpods-max-silver/thumbnail.webp',
    ),
    const Category(
      id: 'clothing',
      name: 'Clothing',
      icon: '👕',
      imageUrl: '$_img/mens-shirts/man-plaid-shirt/thumbnail.webp',
    ),
    const Category(
      id: 'shoes',
      name: 'Shoes',
      icon: '👟',
      imageUrl: '$_img/mens-shoes/nike-air-jordan-1-red-and-black/thumbnail.webp',
    ),
    const Category(
      id: 'accessories',
      name: 'Accessories',
      icon: '⌚',
      imageUrl: '$_img/sunglasses/classic-sun-glasses/thumbnail.webp',
    ),
    const Category(
      id: 'home',
      name: 'Home & Living',
      icon: '🏠',
      imageUrl: '$_img/home-decoration/decoration-swing/thumbnail.webp',
    ),
    const Category(
      id: 'sports',
      name: 'Sports',
      icon: '⚽',
      imageUrl: '$_img/sports-accessories/basketball/thumbnail.webp',
    ),
  ];

  static final List<Product> products = [
    // Electronics
    Product(
      id: 'e1',
      name: 'Wireless Noise-Cancelling Headphones',
      description: 'Premium over-ear headphones with active noise cancellation, 30-hour battery life, and Hi-Res audio support. Perfect for immersive music listening and focused work sessions.',
      price: 249.99,
      originalPrice: 349.99,
      imageUrl: '$_img/mobile-accessories/apple-airpods-max-silver/thumbnail.webp',
      images: [
        '$_img/mobile-accessories/apple-airpods-max-silver/1.webp',
      ],
      categoryId: 'electronics',
      rating: 4.7,
      reviewCount: 234,
      sizes: [],
      colors: ['Black', 'Silver', 'Navy'],
      isFeatured: true,
      reviews: _generateReviews('e1', 5),
    ),
    Product(
      id: 'e2',
      name: 'Smart Watch Pro',
      description: 'Advanced fitness tracker with GPS, heart rate monitoring, blood oxygen sensor, and always-on AMOLED display. Water resistant to 50m.',
      price: 399.99,
      imageUrl: '$_img/mobile-accessories/apple-watch-series-4-gold/thumbnail.webp',
      images: [
        '$_img/mobile-accessories/apple-watch-series-4-gold/1.webp',
        '$_img/mobile-accessories/apple-watch-series-4-gold/2.webp',
        '$_img/mobile-accessories/apple-watch-series-4-gold/3.webp',
      ],
      categoryId: 'electronics',
      rating: 4.5,
      reviewCount: 178,
      sizes: ['40mm', '44mm'],
      colors: ['Midnight', 'Starlight', 'Green'],
      isFeatured: true,
      isNew: true,
      reviews: _generateReviews('e2', 4),
    ),
    Product(
      id: 'e3',
      name: 'Portable Bluetooth Speaker',
      description: 'Compact waterproof speaker with 360-degree sound, 20-hour battery, and built-in microphone for calls. IP67 rated.',
      price: 79.99,
      originalPrice: 99.99,
      imageUrl: '$_img/mobile-accessories/apple-homepod-mini-cosmic-grey/thumbnail.webp',
      images: [
        '$_img/mobile-accessories/apple-homepod-mini-cosmic-grey/1.webp',
      ],
      categoryId: 'electronics',
      rating: 4.3,
      reviewCount: 312,
      sizes: [],
      colors: ['Black', 'Blue', 'Red', 'Green'],
      reviews: _generateReviews('e3', 3),
    ),
    Product(
      id: 'e4',
      name: 'USB-C Fast Charging Hub',
      description: '7-in-1 USB-C hub with HDMI 4K, USB 3.0 ports, SD card reader, and 100W PD charging. Compatible with all USB-C devices.',
      price: 49.99,
      imageUrl: '$_img/mobile-accessories/apple-iphone-charger/thumbnail.webp',
      images: [
        '$_img/mobile-accessories/apple-iphone-charger/1.webp',
        '$_img/mobile-accessories/apple-iphone-charger/2.webp',
      ],
      categoryId: 'electronics',
      rating: 4.4,
      reviewCount: 89,
      sizes: [],
      colors: ['Space Grey'],
      reviews: _generateReviews('e4', 2),
    ),

    // Clothing
    Product(
      id: 'c1',
      name: 'Classic Fit Cotton T-Shirt',
      description: 'Premium 100% organic cotton t-shirt with a relaxed fit. Pre-shrunk fabric with reinforced stitching for lasting comfort.',
      price: 29.99,
      imageUrl: '$_img/mens-shirts/gigabyte-aorus-men-tshirt/thumbnail.webp',
      images: [
        '$_img/mens-shirts/gigabyte-aorus-men-tshirt/1.webp',
        '$_img/mens-shirts/gigabyte-aorus-men-tshirt/2.webp',
      ],
      categoryId: 'clothing',
      rating: 4.6,
      reviewCount: 567,
      sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      colors: ['White', 'Black', 'Navy', 'Grey', 'Forest Green'],
      reviews: _generateReviews('c1', 4),
    ),
    Product(
      id: 'c2',
      name: 'Slim Fit Chino Pants',
      description: 'Modern slim-fit chinos crafted from stretch cotton blend. Features a tapered leg and comfortable mid-rise waist.',
      price: 59.99,
      originalPrice: 79.99,
      imageUrl: '$_img/mens-shirts/man-short-sleeve-shirt/thumbnail.webp',
      images: [
        '$_img/mens-shirts/man-short-sleeve-shirt/1.webp',
        '$_img/mens-shirts/man-short-sleeve-shirt/2.webp',
      ],
      categoryId: 'clothing',
      rating: 4.4,
      reviewCount: 234,
      sizes: ['28', '30', '32', '34', '36'],
      colors: ['Khaki', 'Navy', 'Olive', 'Black'],
      isFeatured: true,
      reviews: _generateReviews('c2', 3),
    ),
    Product(
      id: 'c3',
      name: 'Lightweight Down Jacket',
      description: 'Ultra-light packable down jacket with 800-fill power goose down. Water-resistant shell with elastic cuffs and hem.',
      price: 149.99,
      originalPrice: 199.99,
      imageUrl: '$_img/mens-shirts/men-check-shirt/thumbnail.webp',
      images: [
        '$_img/mens-shirts/men-check-shirt/1.webp',
        '$_img/mens-shirts/men-check-shirt/2.webp',
      ],
      categoryId: 'clothing',
      rating: 4.8,
      reviewCount: 156,
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Black', 'Navy', 'Red'],
      isNew: true,
      reviews: _generateReviews('c3', 5),
    ),

    // Shoes
    Product(
      id: 's1',
      name: 'Running Shoes Ultra Boost',
      description: 'Responsive running shoes with energy-returning cushioning, breathable mesh upper, and Continental rubber outsole for grip.',
      price: 179.99,
      imageUrl: '$_img/mens-shoes/nike-air-jordan-1-red-and-black/thumbnail.webp',
      images: [
        '$_img/mens-shoes/nike-air-jordan-1-red-and-black/1.webp',
        '$_img/mens-shoes/nike-air-jordan-1-red-and-black/2.webp',
        '$_img/mens-shoes/nike-air-jordan-1-red-and-black/3.webp',
      ],
      categoryId: 'shoes',
      rating: 4.7,
      reviewCount: 445,
      sizes: ['7', '8', '9', '10', '11', '12'],
      colors: ['White/Black', 'All Black', 'Grey/Blue'],
      isFeatured: true,
      reviews: _generateReviews('s1', 5),
    ),
    Product(
      id: 's2',
      name: 'Casual Canvas Sneakers',
      description: 'Classic low-top canvas sneakers with vulcanised rubber sole. Timeless design that pairs with everything.',
      price: 54.99,
      imageUrl: '$_img/mens-shoes/puma-future-rider-trainers/thumbnail.webp',
      images: [
        '$_img/mens-shoes/puma-future-rider-trainers/1.webp',
        '$_img/mens-shoes/puma-future-rider-trainers/2.webp',
      ],
      categoryId: 'shoes',
      rating: 4.5,
      reviewCount: 678,
      sizes: ['6', '7', '8', '9', '10', '11', '12'],
      colors: ['White', 'Black', 'Red', 'Navy'],
      reviews: _generateReviews('s2', 4),
    ),
    Product(
      id: 's3',
      name: 'Leather Chelsea Boots',
      description: 'Handcrafted genuine leather Chelsea boots with elastic side panels and pull-tab. Goodyear welted construction.',
      price: 219.99,
      imageUrl: '$_img/mens-shoes/sports-sneakers-off-white-red/thumbnail.webp',
      images: [
        '$_img/mens-shoes/sports-sneakers-off-white-red/1.webp',
        '$_img/mens-shoes/sports-sneakers-off-white-red/2.webp',
      ],
      categoryId: 'shoes',
      rating: 4.6,
      reviewCount: 123,
      sizes: ['7', '8', '9', '10', '11', '12'],
      colors: ['Brown', 'Black'],
      isNew: true,
      reviews: _generateReviews('s3', 3),
    ),

    // Accessories
    Product(
      id: 'a1',
      name: 'Minimalist Leather Wallet',
      description: 'Slim bifold wallet crafted from full-grain leather. Features 6 card slots, 2 bill compartments, and RFID blocking.',
      price: 44.99,
      imageUrl: '$_img/womens-bags/women-handbag-black/thumbnail.webp',
      images: [
        '$_img/womens-bags/women-handbag-black/1.webp',
        '$_img/womens-bags/women-handbag-black/2.webp',
      ],
      categoryId: 'accessories',
      rating: 4.5,
      reviewCount: 234,
      sizes: [],
      colors: ['Brown', 'Black', 'Tan'],
      reviews: _generateReviews('a1', 3),
    ),
    Product(
      id: 'a2',
      name: 'Polarised Aviator Sunglasses',
      description: 'Classic aviator sunglasses with polarised lenses and lightweight titanium frame. UV400 protection.',
      price: 89.99,
      originalPrice: 119.99,
      imageUrl: '$_img/sunglasses/classic-sun-glasses/thumbnail.webp',
      images: [
        '$_img/sunglasses/classic-sun-glasses/1.webp',
        '$_img/sunglasses/classic-sun-glasses/2.webp',
        '$_img/sunglasses/classic-sun-glasses/3.webp',
      ],
      categoryId: 'accessories',
      rating: 4.3,
      reviewCount: 167,
      sizes: [],
      colors: ['Gold/Green', 'Silver/Blue', 'Black/Grey'],
      isFeatured: true,
      reviews: _generateReviews('a2', 4),
    ),
    Product(
      id: 'a3',
      name: 'Canvas Laptop Backpack',
      description: 'Durable waxed canvas backpack with padded 15" laptop compartment, multiple organiser pockets, and leather trim.',
      price: 79.99,
      imageUrl: '$_img/womens-bags/white-faux-leather-backpack/thumbnail.webp',
      images: [
        '$_img/womens-bags/white-faux-leather-backpack/1.webp',
        '$_img/womens-bags/white-faux-leather-backpack/2.webp',
      ],
      categoryId: 'accessories',
      rating: 4.6,
      reviewCount: 345,
      sizes: [],
      colors: ['Olive', 'Navy', 'Grey'],
      reviews: _generateReviews('a3', 4),
    ),

    // Home & Living
    Product(
      id: 'h1',
      name: 'Ceramic Pour-Over Coffee Set',
      description: 'Handmade ceramic dripper with matching server and two cups. Includes stainless steel filter for a clean brew.',
      price: 64.99,
      imageUrl: '$_img/kitchen-accessories/black-aluminium-cup/thumbnail.webp',
      images: [
        '$_img/kitchen-accessories/black-aluminium-cup/1.webp',
        '$_img/kitchen-accessories/black-aluminium-cup/2.webp',
      ],
      categoryId: 'home',
      rating: 4.8,
      reviewCount: 89,
      sizes: [],
      colors: ['White', 'Charcoal', 'Sage'],
      isNew: true,
      reviews: _generateReviews('h1', 3),
    ),
    Product(
      id: 'h2',
      name: 'Scented Soy Candle Set',
      description: 'Set of 3 hand-poured soy candles in cedar, lavender, and vanilla scents. 50-hour burn time each. Cotton wick.',
      price: 34.99,
      imageUrl: '$_img/home-decoration/table-lamp/thumbnail.webp',
      images: [
        '$_img/home-decoration/house-showpiece-plant/1.webp',
      ],
      categoryId: 'home',
      rating: 4.7,
      reviewCount: 201,
      sizes: [],
      colors: [],
      reviews: _generateReviews('h2', 3),
    ),
    Product(
      id: 'h3',
      name: 'Linen Throw Blanket',
      description: 'Stonewashed linen blanket with fringe detail. Lightweight and breathable, perfect for all seasons.',
      price: 89.99,
      originalPrice: 119.99,
      imageUrl: '$_img/furniture/annibale-colombo-bed/thumbnail.webp',
      images: [
        '$_img/furniture/annibale-colombo-bed/1.webp',
        '$_img/furniture/annibale-colombo-bed/2.webp',
      ],
      categoryId: 'home',
      rating: 4.5,
      reviewCount: 145,
      sizes: ['Throw (130x170cm)', 'Full (180x230cm)'],
      colors: ['Natural', 'Dusty Rose', 'Slate Blue'],
      reviews: _generateReviews('h3', 4),
    ),

    // Sports
    Product(
      id: 'sp1',
      name: 'Yoga Mat Premium',
      description: 'Extra thick 6mm natural rubber yoga mat with alignment markings. Non-slip surface on both sides. Includes carry strap.',
      price: 69.99,
      imageUrl: '$_img/sports-accessories/tennis-racket/thumbnail.webp',
      images: [
        '$_img/sports-accessories/tennis-racket/1.webp',
      ],
      categoryId: 'sports',
      rating: 4.6,
      reviewCount: 312,
      sizes: [],
      colors: ['Midnight Blue', 'Sage Green', 'Terracotta'],
      reviews: _generateReviews('sp1', 4),
    ),
    Product(
      id: 'sp2',
      name: 'Resistance Band Set',
      description: 'Set of 5 latex-free resistance bands with varying tensions. Includes door anchor, handles, and ankle straps.',
      price: 29.99,
      imageUrl: '$_img/sports-accessories/baseball-glove/thumbnail.webp',
      images: [
        '$_img/sports-accessories/baseball-glove/1.webp',
        '$_img/sports-accessories/baseball-glove/2.webp',
      ],
      categoryId: 'sports',
      rating: 4.4,
      reviewCount: 567,
      sizes: [],
      colors: [],
      isFeatured: true,
      reviews: _generateReviews('sp2', 3),
    ),
    Product(
      id: 'sp3',
      name: 'Insulated Water Bottle',
      description: 'Double-wall vacuum insulated stainless steel bottle. Keeps drinks cold 24h or hot 12h. BPA-free lid.',
      price: 34.99,
      imageUrl: '$_img/kitchen-accessories/glass/thumbnail.webp',
      images: [
        '$_img/kitchen-accessories/lunch-box/1.webp',
      ],
      categoryId: 'sports',
      rating: 4.7,
      reviewCount: 890,
      sizes: ['500ml', '750ml', '1L'],
      colors: ['Arctic White', 'Matte Black', 'Ocean Blue', 'Rose Gold'],
      reviews: _generateReviews('sp3', 4),
    ),
  ];

  static List<Review> _generateReviews(String productId, int count) {
    final names = ['Alex M.', 'Sarah K.', 'James L.', 'Emma W.', 'David R.'];
    final comments = [
      'Excellent quality! Exceeded my expectations. Highly recommend.',
      'Great value for the price. Very satisfied with this purchase.',
      'Good product overall. Minor issues but nothing dealbreaking.',
      'Love it! The design and build quality are top-notch.',
      'Exactly as described. Fast delivery and well packaged.',
    ];
    final ratings = [5.0, 4.5, 4.0, 5.0, 4.0];

    return List.generate(count, (i) {
      return Review(
        id: '${productId}_r$i',
        userId: 'user_$i',
        userName: names[i % names.length],
        rating: ratings[i % ratings.length],
        comment: comments[i % comments.length],
        date: DateTime.now().subtract(Duration(days: (i + 1) * 7)),
      );
    });
  }

  // Service methods
  Future<List<Product>> getProducts({
    String? categoryId,
    String? searchQuery,
    String? sortBy,
    double? minPrice,
    double? maxPrice,
    double? minRating,
  }) async {
    await Future.delayed(AppConstants.mockNetworkDelay);

    var result = List<Product>.from(products);

    if (categoryId != null) {
      result = result.where((p) => p.categoryId == categoryId).toList();
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      result = result.where((p) =>
          p.name.toLowerCase().contains(query) ||
          p.description.toLowerCase().contains(query)).toList();
    }
    if (minPrice != null) {
      result = result.where((p) => p.price >= minPrice).toList();
    }
    if (maxPrice != null) {
      result = result.where((p) => p.price <= maxPrice).toList();
    }
    if (minRating != null) {
      result = result.where((p) => p.rating >= minRating).toList();
    }

    switch (sortBy) {
      case 'price_asc':
        result.sort((a, b) => a.price.compareTo(b.price));
      case 'price_desc':
        result.sort((a, b) => b.price.compareTo(a.price));
      case 'rating':
        result.sort((a, b) => b.rating.compareTo(a.rating));
      case 'newest':
        result.sort((a, b) => (b.isNew ? 1 : 0).compareTo(a.isNew ? 1 : 0));
    }

    return result;
  }

  Future<Product?> getProductById(String id) async {
    await Future.delayed(AppConstants.mockNetworkDelay);
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<List<Product>> getFeaturedProducts() async {
    await Future.delayed(AppConstants.mockNetworkDelay);
    return products.where((p) => p.isFeatured).toList();
  }

  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return categories;
  }
}
