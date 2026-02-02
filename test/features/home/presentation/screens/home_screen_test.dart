import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/home/presentation/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'sign_language_to_voice': 'Sign to Voice',
      'sign_language_to_voice_desc': 'Convert sign language to voice',
      'voice_to_avatar': 'Voice to Avatar',
      'voice_to_avatar_desc': 'Convert voice to avatar',
      'video_to_avatar': 'Video to Avatar',
      'video_to_avatar_desc': 'Convert video to avatar',
      'welcome_back': 'Welcome Back',
      'how_can_help': 'How can I help?',
      'quick_access': 'Quick Access',
      'recent': 'Recent',
      'saved': 'Saved',
      'languages': 'Languages',
      'help': 'Help',
      'recent_activity': 'Recent Activity',
      'view_all': 'View All',
      'sign_to_voice_session': 'Sign Session',
      'hours_ago': '{} hours ago',
      'min_duration': '{} min',
      'voice_to_avatar_session': 'Voice Session',
      'yesterday': 'Yesterday',
      'video_conversion': 'Video Conversion',
      'days_ago': '{} days ago',
    };
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  Widget createHomeScreen() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      startLocale: const Locale('en'),
      assetLoader: MockAssetLoader(),
      child: Builder(
        builder: (context) => const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );
  }

  testWidgets('HomeScreen renders feature cards with InkWell', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    // Check for keys/values
    bool findsText(String key, String value) {
      return find.text(key).evaluate().isNotEmpty || find.text(value).evaluate().isNotEmpty;
    }

    expect(findsText('sign_language_to_voice', 'Sign to Voice'), isTrue);
    expect(findsText('voice_to_avatar', 'Voice to Avatar'), isTrue);
    expect(findsText('video_to_avatar', 'Video to Avatar'), isTrue);

    // Verify InkWell usage for feature cards
    expect(find.byType(InkWell), findsAtLeastNWidgets(3));
  });

  testWidgets('Notifications button has tooltip', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    final notificationButtonFinder = find.byIcon(Icons.notifications);
    expect(notificationButtonFinder, findsOneWidget);

    // Check for tooltip
    expect(find.byTooltip('Notifications'), findsOneWidget);
  });
}
