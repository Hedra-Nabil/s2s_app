import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/home/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('HomeScreen has notification tooltip and interactive feature cards', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          startLocale: const Locale('en'),
          saveLocale: false,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    // Force a rebuild to ensure widgets are ready
    await tester.pump();

    // 1. Verify Notification Tooltip
    final notificationBtnFinder = find.ancestor(
      of: find.byIcon(Icons.notifications),
      matching: find.byType(IconButton),
    );
    expect(notificationBtnFinder, findsOneWidget);

    final IconButton btn = tester.widget(notificationBtnFinder);
    // Accepts either key or translated value depending on test env asset loading
    expect(btn.tooltip, anyOf('Notifications', 'notifications'));

    // 2. Verify InkWells exist
    // Check for one of the cards
    final iconFinder = find.byIcon(Icons.sign_language);
    expect(iconFinder, findsOneWidget);

    final inkWellFinder = find.ancestor(
      of: iconFinder,
      matching: find.byType(InkWell),
    );
    expect(inkWellFinder, findsOneWidget);

    // 3. Verify Interaction
    await tester.tap(inkWellFinder);
    await tester.pumpAndSettle();

    // Verify we navigated to SignToVoiceScreen
    // SignToVoiceScreen has 'Sign to Voice' text in AppBar
    expect(find.text('Sign to Voice'), findsOneWidget);
  });
}
