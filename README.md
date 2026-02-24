# ShopEase — Flutter E-Commerce Showcase

A feature-complete e-commerce demo app built with **Flutter 3.24+**, **Riverpod**, **GoRouter**, and **Material 3**. Demonstrates production-ready architecture patterns suitable for portfolio or interview presentation.

## Features

- **Authentication** — Login, registration, and forgot password flows with auth guard
- **Home** — Hero banner carousel, category horizontal scroll, featured products grid, pull-to-refresh
- **Product Catalog** — Grid view with search (debounced), category/price/rating filters, sort options
- **Product Detail** — Image gallery, size/variant selector, reviews, Hero animation from grid
- **Cart** — Item list with quantity controls, swipe-to-remove, price summary (subtotal/shipping/tax/total)
- **Checkout** — Address form, payment method selector, order summary, confirmation screen
- **Order History** — Order list, detail view, status stepper (placed → shipped → delivered)
- **Profile** — Avatar, user info, light/dark theme toggle, logout
- **Responsive Layout** — Bottom nav → rail → drawer adapts to phone/tablet/desktop
- **Animations** — Shimmer loading skeletons, staggered list animations, page transitions

## Architecture

```
lib/
├── main.dart                    # ProviderScope + ShopEaseApp (ConsumerWidget)
├── core/
│   ├── theme/                   # Light + dark ThemeData, brand colours
│   ├── constants/               # Spacing, sizing, durations
│   ├── router/                  # GoRouter with auth redirect guard
│   ├── shell/                   # Adaptive bottom nav / rail shell
│   ├── responsive/              # Material 3 breakpoints, ResponsiveBuilder
│   └── animations/              # Shimmer, fade-slide, duration constants
├── features/
│   ├── auth/                    # Login, register, forgot password
│   ├── home/                    # Banner, categories, featured products
│   ├── products/                # Catalog, detail, filters, sort
│   ├── cart/                    # Cart management, price summary
│   ├── checkout/                # Address, payment, confirmation
│   ├── orders/                  # History, detail, status stepper
│   └── profile/                 # User info, theme toggle
└── shared/widgets/              # Search bar, loading skeleton, empty state
```

**State management**: Riverpod (`StateNotifierProvider` + `FutureProvider`)
**Navigation**: GoRouter with `ShellRoute` for bottom nav
**Data layer**: Mock services implementing abstract interfaces — swap for real APIs with no UI changes

## Getting Started

### Prerequisites

- Flutter SDK 3.24+ ([install guide](https://docs.flutter.dev/get-started/install))
- Dart SDK 3.5.4+

### Setup

```bash
git clone <repo-url>
cd flutter_ecommerce_showcase
flutter pub get
```

### Run

```bash
# Mobile (connected device or emulator)
flutter run

# Web
flutter run -d chrome

# Build for web deployment
flutter build web
```

### Test

```bash
flutter test
```

### Demo Credentials

| Field    | Value               |
|----------|---------------------|
| Email    | demo@shopease.com   |
| Password | password            |

Any email/password combination is accepted by the mock auth service.

## Dependencies

| Package | Purpose |
|---------|---------|
| `flutter_riverpod` | State management |
| `go_router` | Declarative routing with auth guard |
| `cached_network_image` | Image caching with placeholders |
| `intl` | Date/currency formatting |
| `google_fonts` | Typography |
| `flutter_staggered_grid_view` | Masonry grid layout |
| `smooth_page_indicator` | Carousel dots |

## Test Coverage

76 tests across models, services, and widgets:

- **Model tests** — Computed properties, `copyWith`, field storage for all 7 models
- **Service tests** — Auth (login/register/logout/validation), cart (add/remove/quantity/pricing), products (filter/sort/search/categories), orders (place/retrieve)
- **Widget smoke test** — App bootstrap with Riverpod + GoRouter

## Mock Data Strategy

All services implement abstract interfaces. Mock implementations provide realistic demo data (19 products across 6 categories). To connect a real backend, only the service implementation changes — no UI or provider modifications required.

```
Interface           Mock                  Real (future)
AuthService         MockAuthService       FirebaseAuthService
ProductService      MockProductService    ApiProductService
CartService         MockCartService       ApiCartService
OrderService        MockOrderService      ApiOrderService
```

## License

This project is a showcase/portfolio application.
