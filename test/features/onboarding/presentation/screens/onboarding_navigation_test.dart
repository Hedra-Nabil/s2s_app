import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:s2s_app/features/onboarding/presentation/screens/onboarding_screen_1.dart';
import 'package:s2s_app/features/onboarding/presentation/screens/onboarding_screen_2.dart';
import 'package:s2s_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>> pushedRoutes = [];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    pushedRoutes.add(route);
    super.didPush(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      pushedRoutes.add(newRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}

class _MockAssetLoader extends AssetLoader {
  const _MockAssetLoader();
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      'skip': 'Skip',
      'app_name': 'SignVoice',
      'voice_to_sign_sign_to_voice': 'Voice to Sign',
      'onboarding_desc': 'Desc',
      'how_it_works': 'How it works',
      'how_it_works_desc': 'Desc',
      'sign_to_voice_feature': 'Feature 1',
      'sign_to_voice_feature_desc': 'Desc 1',
      'voice_to_avatar_feature': 'Feature 2',
      'voice_to_avatar_feature_desc': 'Desc 2',
      'video_to_avatar_feature': 'Feature 3',
      'video_to_avatar_feature_desc': 'Desc 3',
      'log_in': 'Log In',
      'sign_up': 'Sign Up',
      'email_address': 'Email',
      'email_hint': 'Hint',
      'password': 'Password',
      'password_hint': 'Hint',
      'forgot_password': 'Forgot?',
      'or_continue_with': 'Or',
      'google': 'Google',
      'apple': 'Apple',
      'create_password': 'Create',
      'full_name': 'Name',
      'full_name_hint': 'Hint',
    };
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('OnboardingScreen1 Skip button navigates to AuthScreen', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          assetLoader: const _MockAssetLoader(),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                navigatorObservers: [mockObserver],
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: const Scaffold(body: OnboardingScreen1()),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    final skipButtonFinder = find.text('Skip');
    expect(skipButtonFinder, findsOneWidget);

    await tester.tap(skipButtonFinder);
    await tester.pumpAndSettle();

    // Verify a replacement route was pushed
    expect(mockObserver.pushedRoutes.length, greaterThan(0));
    final route = mockObserver.pushedRoutes.last;
    expect(route is MaterialPageRoute, isTrue);
    // Ideally we check if the route builds AuthScreen, but checking finding AuthScreen widgets is easier
    expect(find.byType(AuthScreen), findsOneWidget);
  });

  testWidgets('OnboardingScreen2 Skip button navigates to AuthScreen', (WidgetTester tester) async {
    final mockObserver = MockNavigatorObserver();

    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          assetLoader: const _MockAssetLoader(),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                navigatorObservers: [mockObserver],
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: const Scaffold(body: OnboardingScreen2()),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
    });

    final skipButtonFinder = find.text('Skip');
    expect(skipButtonFinder, findsOneWidget);

    await tester.tap(skipButtonFinder);
    await tester.pumpAndSettle();

    expect(mockObserver.pushedRoutes.length, greaterThan(0));
    expect(find.byType(AuthScreen), findsOneWidget);
  });
}
