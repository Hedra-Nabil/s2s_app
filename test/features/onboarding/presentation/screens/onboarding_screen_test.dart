import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s2s_app/features/onboarding/presentation/screens/onboarding_screen.dart';

class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'get_started': 'Get Started',
      'continue': 'Continue',
      'skip': 'Skip',
      'app_name': 'SignVoice',
      'voice_to_sign_sign_to_voice': 'Voice to Sign & Sign to Voice',
      'onboarding_desc': 'Description',
      'how_it_works': 'How it works',
      'how_it_works_desc': 'Description',
      'sign_to_voice_feature': 'Sign to Voice',
      'sign_to_voice_feature_desc': 'Desc',
      'voice_to_avatar_feature': 'Voice to Avatar',
      'voice_to_avatar_feature_desc': 'Desc',
      'video_to_avatar_feature': 'Video to Avatar',
      'video_to_avatar_feature_desc': 'Desc',
      'log_in': 'Log In',
      'sign_up': 'Sign Up',
      'tagline': 'Tagline',
      'email_address': 'Email Address',
      'email_hint': 'Enter email',
      'password': 'Password',
      'password_hint': 'Enter password',
      'forgot_password': 'Forgot Password',
      'full_name': 'Full Name',
      'full_name_hint': 'Enter name',
      'create_password': 'Create Password',
      'or_continue_with': 'Or continue with',
      'google': 'Google',
      'apple': 'Apple',
    };
  }
}

class TestNavigatorObserver extends NavigatorObserver {
  int didReplaceCallCount = 0;

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    didReplaceCallCount++;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

void main() {
  late TestNavigatorObserver testNavigatorObserver;

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  setUp(() {
    testNavigatorObserver = TestNavigatorObserver();
  });

  Widget createWidgetUnderTest() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      assetLoader: MockAssetLoader(),
      startLocale: const Locale('en'),
      saveLocale: false,
      child: MaterialApp(
        home: const OnboardingScreen(),
        navigatorObservers: [testNavigatorObserver],
      ),
    );
  }

  testWidgets('Tapping Skip button navigates to AuthScreen (calls pushReplacement)', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    // Verify Skip button exists on first page
    // Note: EasyLocalization might not load assets in time in test environment, falling back to key 'skip'
    final skipFinder = find.text('Skip');
    final skipKeyFinder = find.text('skip');
    final finder = skipFinder.evaluate().isNotEmpty ? skipFinder : skipKeyFinder;

    expect(finder, findsOneWidget, reason: 'Skip button should be visible (either translated or key)');

    // Tap Skip
    await tester.tap(finder);
    await tester.pumpAndSettle();

    // Verify navigation occurred (didReplace should be called once)
    expect(testNavigatorObserver.didReplaceCallCount, 1);
  });
}
