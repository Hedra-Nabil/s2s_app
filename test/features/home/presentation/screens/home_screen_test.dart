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

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      assetLoader: const _MockAssetLoader(),
      startLocale: const Locale('en'),
      saveLocale: false,
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  testWidgets('HomeScreen displays feature cards', (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();
    });

    // Verify feature cards exist
    expect(find.byIcon(Icons.sign_language), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget);
    expect(find.byIcon(Icons.videocam), findsOneWidget);

    // Verify Notification button
    expect(find.byIcon(Icons.notifications), findsOneWidget);
  });
}

class _MockAssetLoader extends AssetLoader {
  const _MockAssetLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'sign_language_to_voice': 'Sign to Voice',
      'sign_language_to_voice_desc': 'Convert sign to speech',
      'voice_to_avatar': 'Voice to Avatar',
      'voice_to_avatar_desc': 'Convert speech to avatar',
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
      'voice_to_avatar_session': 'Voice Session',
      'video_conversion': 'Video Conversion',
      'hours_ago': '{} hours ago',
      'min_duration': '{} min',
      'yesterday': 'Yesterday',
      'days_ago': '{} days ago',
    };
  }
}
