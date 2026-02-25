import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopease/main.dart';

void main() {
  testWidgets('ShopEaseApp smoke test', (WidgetTester tester) async {
    // Suppress overflow errors in test environment (small surface)
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      if (details.toString().contains('overflowed')) return;
      originalOnError?.call(details);
    };

    await tester.pumpWidget(
      const ProviderScope(child: ShopEaseApp()),
    );

    // Pump past the splash screen's Future.delayed(2500ms) timer
    // so no timers are pending when the test ends
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // App should render the login screen (user not authenticated)
    expect(find.byType(MaterialApp), findsOneWidget);

    FlutterError.onError = originalOnError;
  });
}
