import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final isDarkMode = ref.watch(themeModeProvider);
    final colorScheme = Theme.of(context).colorScheme;
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        children: [
          // Avatar & info
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: AppConstants.avatarLg / 2,
                  backgroundColor: colorScheme.primaryContainer,
                  child: Text(
                    user?.name.isNotEmpty == true
                        ? user!.name[0].toUpperCase()
                        : '?',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
                const SizedBox(height: AppConstants.spacingSm),
                Text(
                  user?.name ?? 'Guest',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  user?.email ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingLg),
          const Divider(),

          // Menu items
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: const Text('My Orders'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/orders'),
          ),
          const Divider(height: 1),
          SwitchListTile(
            secondary: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: (v) {
              ref.read(themeModeProvider.notifier).state = v;
            },
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'ShopEase',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(Icons.shopping_bag, size: 48, color: colorScheme.primary),
                children: [
                  const Text('A showcase e-commerce application built with Flutter, '
                      'demonstrating modern app architecture with Riverpod, GoRouter, '
                      'and Material 3 design.'),
                ],
              );
            },
          ),
          const Divider(height: 1),
          const SizedBox(height: AppConstants.spacingLg),
          OutlinedButton.icon(
            onPressed: () async {
              final shouldLogout = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
              if (shouldLogout == true) {
                await ref.read(authProvider.notifier).logout();
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: OutlinedButton.styleFrom(
              foregroundColor: colorScheme.error,
              side: BorderSide(color: colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
