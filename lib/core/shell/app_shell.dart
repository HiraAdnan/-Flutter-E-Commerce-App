import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../responsive/adaptive_scaffold.dart';

final currentTabProvider = StateProvider<int>((ref) => 0);

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  static const _destinations = [
    NavigationDestinationData(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: 'Home',
    ),
    NavigationDestinationData(
      icon: Icons.search_outlined,
      selectedIcon: Icons.search,
      label: 'Search',
    ),
    NavigationDestinationData(
      icon: Icons.shopping_cart_outlined,
      selectedIcon: Icons.shopping_cart,
      label: 'Cart',
    ),
    NavigationDestinationData(
      icon: Icons.person_outlined,
      selectedIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  static const _routes = ['/home', '/products', '/cart', '/profile'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _routes.indexOf(location).clamp(0, _routes.length - 1);

    return AdaptiveScaffold(
      body: child,
      currentIndex: currentIndex,
      onDestinationSelected: (index) {
        context.go(_routes[index]);
      },
      destinations: _destinations,
    );
  }
}
