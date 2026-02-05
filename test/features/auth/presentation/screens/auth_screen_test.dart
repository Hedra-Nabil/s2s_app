import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {
      "app_name": "SignVoice",
      "tagline": "Breaking barriers",
      "log_in": "Log In",
      "sign_up": "Sign Up",
      "email_address": "Email Address",
      "email_hint": "name@example.com",
      "password": "Password",
      "password_hint": "Enter your password",
      "forgot_password": "Forgot Password?",
      "or_continue_with": "Or continue with",
      "google": "Google",
      "apple": "Apple",
      "create_password": "Create a password",
      "full_name": "Full Name",
      "full_name_hint": "Enter your full name",
      "show_password": "Show password",
      "hide_password": "Hide password",
    };
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('AuthScreen password field has visibility toggle', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        assetLoader: MockAssetLoader(),
        startLocale: const Locale('en'),
        saveLocale: false,
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify visibility toggle exists (initially obscured, so show "eye" icon to make it visible)
    // We expect at least one password field
    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    // Wait, there are TWO password fields (Login and Signup).
    // But TabBarView renders only one tab at a time usually?
    // Or maybe it renders both?
    // TabBarView keeps state.
    // _buildLoginForm is first. _buildSignupForm is second.
    // If only one is built, we find one.

    // Let's verify we find at least one.
    expect(find.byIcon(Icons.visibility_outlined), findsAtLeastNWidgets(1));

    // Tap the first one found
    await tester.tap(find.byIcon(Icons.visibility_outlined).first);
    await tester.pump();

    // Should now show "eye-off" icon (to hide)
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

    // And tooltip should be correct
    // "Hide password" (since it is now visible)
    // If translations are not loaded, it will use the key 'hide_password'
    if (find.byTooltip("Hide password").evaluate().isEmpty) {
       expect(find.byTooltip("hide_password"), findsOneWidget);
    } else {
       expect(find.byTooltip("Hide password"), findsOneWidget);
    }
  });
}
