import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Mock AssetLoader
class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {};
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('AuthScreen shows password fields and toggles visibility',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(
        EasyLocalization(
          supportedLocales: const [Locale('en')],
          path: 'assets/translations',
          assetLoader: MockAssetLoader(),
          startLocale: const Locale('en'),
          child: MaterialApp(
            home: const AuthScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();
    });

    // Find visibility icon (initially visible since obscureText is true)
    final visibilityIcon = find.byIcon(Icons.visibility);
    expect(visibilityIcon, findsAtLeastNWidgets(1));

    // Verify tooltip 'show_password' exists (key is returned by mock)
    expect(find.byTooltip('show_password'), findsAtLeastNWidgets(1));

    // Tap the first visibility icon
    await tester.tap(visibilityIcon.first);
    await tester.pump();

    // Now it should show visibility_off
    expect(find.byIcon(Icons.visibility_off), findsOneWidget);

    // Verify tooltip changed to 'hide_password'
    expect(find.byTooltip('hide_password'), findsOneWidget);
  });
}
