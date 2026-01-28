import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:s2s_app/features/onboarding/presentation/screens/onboarding_screen_2.dart';

class MockAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    // Return empty map to force using keys, avoiding locale matching issues
    return {};
  }
}

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('OnboardingScreen2 has merged semantics for feature cards', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        assetLoader: MockAssetLoader(),
        startLocale: const Locale('en'),
        child: const MaterialApp(
          home: OnboardingScreen2(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify text is present (using keys since loader returns empty)
    expect(find.text('sign_to_voice_feature'), findsOneWidget);

    // Verify Semantics
    // We expect the card to be a single semantic node with combined label (keys).
    // The label will contain "sign_to_voice_feature" and "sign_to_voice_feature_desc".

    final signToVoiceCard = find.bySemanticsLabel(RegExp(r'sign_to_voice_feature.*sign_to_voice_feature_desc', dotAll: true));

    // This expectation should FAIL currently because they are separate text nodes.
    // Once we add MergeSemantics, this should PASS.
    // For now, I will comment it out or expect it to findNothing to verify "before" state,
    // BUT the plan is to implement the change then run the test.
    // So I will leave the expectation as "findsOneWidget", knowing it will fail if I run it now,
    // and pass after I edit the code.

    expect(signToVoiceCard, findsOneWidget, reason: 'Sign to Voice card should have merged semantics');

    // Check Voice to Avatar card as well
    final voiceToAvatarCard = find.bySemanticsLabel(RegExp(r'voice_to_avatar_feature.*voice_to_avatar_feature_desc', dotAll: true));
     expect(voiceToAvatarCard, findsOneWidget, reason: 'Voice to Avatar card should have merged semantics');
  });
}
