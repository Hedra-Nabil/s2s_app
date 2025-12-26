
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s2s_app/main.dart';
import 'package:s2s_app/core/di/injection_container.dart' as di;
import 'package:s2s_app/features/home/presentation/screens/home_screen.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await di.init();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('HomeScreen renders correctly', (WidgetTester tester) async {
    // Wrap with EasyLocalization and MaterialApp
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        startLocale: const Locale('en'),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Wait for translations
    await tester.pumpAndSettle();

    // Verify header exists
    expect(find.text('SignVoice'), findsOneWidget);

    // Verify feature cards exist (by icon)
    expect(find.byIcon(Icons.sign_language), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget); // Voice to avatar
    expect(find.byIcon(Icons.videocam), findsOneWidget); // Video to avatar
  });
}
