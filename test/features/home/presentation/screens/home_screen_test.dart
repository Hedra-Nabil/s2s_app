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

  testWidgets('HomeScreen shows tooltips and accessible cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Verify Notification Button Tooltip
    final notificationBtnFinder = find.widgetWithIcon(IconButton, Icons.notifications);
    expect(notificationBtnFinder, findsOneWidget);

    final IconButton notificationBtn = tester.widget(notificationBtnFinder);

    // We expect the tooltip to be present.
    // Since translation keys are not found, it usually returns the key "notifications".
    // Or if it finds it, "Notifications".
    // We'll check if it is NOT null, and preferably equals the key.
    expect(notificationBtn.tooltip, isNotNull, reason: "Tooltip should not be null");
    expect(notificationBtn.tooltip, 'notifications', reason: "Tooltip should match key or translation");

    // 2. Verify Feature Cards use InkWell
    // Find one of the feature cards by text key (since translation fails, key is displayed)
    final featureCardText = find.text('sign_language_to_voice');
    expect(featureCardText, findsOneWidget);

    final inkWellAncestor = find.ancestor(
      of: featureCardText,
      matching: find.byType(InkWell),
    );

    // Expect to find InkWell ancestor (Fail if currently GestureDetector)
    expect(inkWellAncestor, findsOneWidget, reason: "Feature card should be wrapped in InkWell for accessibility");
  });
}
