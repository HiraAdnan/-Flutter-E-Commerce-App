class AppConstants {
  AppConstants._();

  // Spacing
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacingXxl = 48;

  // Border radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 999;

  // Sizing
  static const double iconSm = 20;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;

  static const double avatarSm = 32;
  static const double avatarMd = 48;
  static const double avatarLg = 72;

  static const double buttonHeight = 52;
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 80;

  // Product grid
  static const double productCardWidth = 170;
  static const double productCardAspectRatio = 0.72;
  static const int productsPerRow = 2;
  static const int productsPerRowTablet = 3;
  static const int productsPerRowDesktop = 4;

  // Durations
  static const Duration durationFast = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 350);
  static const Duration durationSlow = Duration(milliseconds: 500);
  static const Duration searchDebounce = Duration(milliseconds: 400);

  // API / Mock
  static const Duration mockNetworkDelay = Duration(milliseconds: 800);
}
