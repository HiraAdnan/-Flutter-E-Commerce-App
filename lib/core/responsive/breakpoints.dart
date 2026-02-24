class Breakpoints {
  Breakpoints._();

  static const double compact = 0;     // Phone
  static const double medium = 600;    // Tablet portrait
  static const double expanded = 840;  // Tablet landscape / small desktop
  static const double large = 1200;    // Desktop
}

enum ScreenSize { compact, medium, expanded, large }

ScreenSize getScreenSize(double width) {
  if (width >= Breakpoints.large) return ScreenSize.large;
  if (width >= Breakpoints.expanded) return ScreenSize.expanded;
  if (width >= Breakpoints.medium) return ScreenSize.medium;
  return ScreenSize.compact;
}
