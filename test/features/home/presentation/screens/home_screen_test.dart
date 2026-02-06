import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/home/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'welcome_back': 'Welcome back',
      'how_can_help': 'How can help',
      'sign_language_to_voice': 'Sign Language to Voice',
      'sign_language_to_voice_desc': 'Desc',
      'voice_to_avatar': 'Voice to Avatar',
      'voice_to_avatar_desc': 'Desc',
      'video_to_avatar': 'Video to Avatar',
      'video_to_avatar_desc': 'Desc',
      'quick_access': 'Quick Access',
      'recent': 'Recent',
      'saved': 'Saved',
      'languages': 'Languages',
      'help': 'Help',
      'recent_activity': 'Recent Activity',
      'view_all': 'View All',
      'sign_to_voice_session': 'Sign to Voice Session',
      'hours_ago': '{hours} hours ago',
      'min_duration': '{minutes} min duration',
      'voice_to_avatar_session': 'Voice to Avatar Session',
      'yesterday': 'Yesterday',
      'video_conversion': 'Video Conversion',
      'days_ago': '{days} days ago',
      'notifications': 'Notifications',
    };
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('HomeScreen has notification button with tooltip', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          assetLoader: MockAssetLoader(),
          startLocale: const Locale('en'),
          saveLocale: false,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    // Find the notifications icon button
    final notificationButtonFinder = find.widgetWithIcon(IconButton, Icons.notifications);
    expect(notificationButtonFinder, findsOneWidget);

    // Verify tooltip exists (either translated or key)
    final tooltipFinder = find.byTooltip('Notifications');
    final fallbackTooltipFinder = find.byTooltip('notifications');

    if (fallbackTooltipFinder.evaluate().isNotEmpty) {
      expect(fallbackTooltipFinder, findsOneWidget);
    } else {
      expect(tooltipFinder, findsOneWidget);
    }
  });

  testWidgets('HomeScreen feature cards use InkWell for accessibility', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          assetLoader: MockAssetLoader(),
          startLocale: const Locale('en'),
          saveLocale: false,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    // Verify that the text "Sign Language to Voice" (or its key) is inside an InkWell.
    final textFinder = find.text('Sign Language to Voice');
    final fallbackTextFinder = find.text('sign_language_to_voice');

    final targetText = textFinder.evaluate().isNotEmpty ? textFinder : fallbackTextFinder;

    final signLanguageCard = find.ancestor(
      of: targetText,
      matching: find.byType(InkWell),
    );

    expect(signLanguageCard, findsOneWidget);
  });
}
