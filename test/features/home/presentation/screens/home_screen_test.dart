import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s2s_app/features/home/presentation/screens/home_screen.dart';

// Mock Asset Loader
class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'welcome_back': 'Welcome back, Sarah!',
      'notifications': 'Notifications',
      'sign_language_to_voice': 'Sign Language to Voice',
      'voice_to_avatar': 'Voice to Avatar',
      'video_to_avatar': 'Video to Avatar',
    };
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('HomeScreen renders with InkWells and Tooltips', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          assetLoader: MockAssetLoader(),
          startLocale: const Locale('en'),
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
    });

    // Strategy: Look for text that matches either the key OR the value, to be robust.
    Finder findTextOrKey(String key, String value) {
      return find.byWidgetPredicate((widget) {
        if (widget is Text) {
          final data = widget.data;
          return data == key || data == value;
        }
        return false;
      });
    }

    // Verify Notification Tooltip
    // If localization fails, tooltip might be the key 'notifications'.
    // If it succeeds, it is 'Notifications'.
    // But tooltip property is not a widget, it's a property of IconButton or wrapped in Tooltip widget.
    // find.byTooltip looks for Tooltip widget message.
    final notificationTooltipFinder = find.byTooltip('Notifications');
    final notificationTooltipKeyFinder = find.byTooltip('notifications');

    // Verify Feature Cards use InkWell
    final featureCard1InkWell = find.ancestor(
      of: findTextOrKey('sign_language_to_voice', 'Sign Language to Voice'),
      matching: find.byType(InkWell),
    );

    final featureCard2InkWell = find.ancestor(
      of: findTextOrKey('voice_to_avatar', 'Voice to Avatar'),
      matching: find.byType(InkWell),
    );

    final featureCard3InkWell = find.ancestor(
      of: findTextOrKey('video_to_avatar', 'Video to Avatar'),
      matching: find.byType(InkWell),
    );

    // Assertions
    // Check if either tooltip is found (key or value)
    bool notificationFound = notificationTooltipFinder.evaluate().isNotEmpty ||
                             notificationTooltipKeyFinder.evaluate().isNotEmpty;
    expect(notificationFound, isTrue, reason: "Notification tooltip not found");

    expect(featureCard1InkWell, findsOneWidget, reason: "InkWell for Card 1 not found");
    expect(featureCard2InkWell, findsOneWidget, reason: "InkWell for Card 2 not found");
    expect(featureCard3InkWell, findsOneWidget, reason: "InkWell for Card 3 not found");
  });
}
