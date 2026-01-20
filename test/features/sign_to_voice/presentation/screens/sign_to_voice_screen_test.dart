import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen has accessible recording button', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: SignToVoiceScreen(),
    ));

    // 1. Verify recording button semantics
    // The recording button currently lacks semantics, so this test should fail if we assert it has them.
    // Or we can find it by type/key and check properties.
    // Since we plan to add 'Start recording', let's check for that label.

    // We expect this to FAIL initially or we can write it to find the current state first.
    // Let's write the test for the DESIRED state.

    final recordButtonFinder = find.bySemanticsLabel('Start recording');
    expect(recordButtonFinder, findsOneWidget);

    // Verify it is a button
    expect(tester.getSemantics(recordButtonFinder), matchesSemantics(
      label: 'Start recording',
      isButton: true,
      hasTapAction: true,
      isEnabled: true,
      isFocusable: true,
    ));
  });

  testWidgets('SignToVoiceScreen icon buttons have tooltips', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SignToVoiceScreen(),
    ));

    expect(find.byTooltip('Go back'), findsOneWidget);
    expect(find.byTooltip('More options'), findsOneWidget);
    expect(find.byTooltip('Copy transcript'), findsOneWidget);
    expect(find.byTooltip('Download audio'), findsOneWidget);
  });
}
