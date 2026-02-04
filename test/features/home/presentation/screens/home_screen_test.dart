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
      'sign_language_to_voice_desc': 'Desc 1',
      'voice_to_avatar': 'Voice to Avatar',
      'voice_to_avatar_desc': 'Desc 2',
      'video_to_avatar': 'Video to Avatar',
      'video_to_avatar_desc': 'Desc 3',
      'quick_access': 'Quick Access',
      'recent': 'Recent',
      'saved': 'Saved',
      'languages': 'Languages',
      'help': 'Help',
      'recent_activity': 'Recent Activity',
      'view_all': 'View All',
      'sign_to_voice_session': 'Session 1',
      'voice_to_avatar_session': 'Session 2',
      'video_conversion': 'Conversion',
      'hours_ago': '2 hours ago',
      'min_duration': '5 min duration',
      'days_ago': '2 days ago',
      'yesterday': 'Yesterday',
      'notifications': 'Notifications',
    };
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      assetLoader: MockAssetLoader(),
      startLocale: const Locale('en'),
      saveLocale: false,
      child: MaterialApp(
        home: const HomeScreen(),
      ),
    );
  }

  testWidgets('HomeScreen renders with correct accessibility features', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify screen renders
    expect(find.byType(HomeScreen), findsOneWidget);

    // Verify Notification button has tooltip
    // We check for either the translated value 'Notifications' or the key 'notifications'
    final tooltipFinder = find.byWidgetPredicate((widget) {
      if (widget is Tooltip) {
        return widget.message == 'Notifications' || widget.message == 'notifications';
      }
      return false;
    });

    // This expectation is what verifies our fix for the notification button
    expect(tooltipFinder, findsOneWidget);

    // Helper to find text by value or key
    Finder findTextOrKey(String text, String key) {
      return find.byWidgetPredicate((widget) {
        if (widget is Text) {
          final data = widget.data;
          return data == text || data == key;
        }
        return false;
      });
    }

    // Verify Feature Cards use InkWell for accessibility/ripple
    // This expects InkWell to be an ancestor of the card title.
    // This validates our fix for feature cards (changing GestureDetector to InkWell)
    expect(find.ancestor(of: findTextOrKey('Sign Language to Voice', 'sign_language_to_voice'), matching: find.byType(InkWell)), findsOneWidget);
    expect(find.ancestor(of: findTextOrKey('Voice to Avatar', 'voice_to_avatar'), matching: find.byType(InkWell)), findsOneWidget);
    expect(find.ancestor(of: findTextOrKey('Video to Avatar', 'video_to_avatar'), matching: find.byType(InkWell)), findsOneWidget);
  });
}
