import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen has accessible recording button', (WidgetTester tester) async {
    // Pump the widget
    await tester.pumpWidget(const MaterialApp(home: SignToVoiceScreen()));

    // Debug: print semantics
    // print(tester.getSemantics(find.byType(SignToVoiceScreen)));
    // Accessing semantics directly isn't string convertable easily, but we can try debugDumpSemantics if we were in a flutter run.

    // Use a specific finder for the button if semantics aren't there yet, but we want to test FOR semantics.
    // So we try to find by the label we INTEND to add.
    final recordingButtonFinder = find.bySemanticsLabel('Start recording');

    // This expectation will fail initially
    expect(recordingButtonFinder, findsOneWidget);

    // Verify it is a button
    expect(tester.getSemantics(recordingButtonFinder), matchesSemantics(
      label: 'Start recording',
      isButton: true,
      hasTapAction: true,
      hasFocusAction: true, // InkWell is focusable
      isEnabled: true,
      hasEnabledState: true,
      isFocusable: true,
    ));
  });

  testWidgets('SignToVoiceScreen IconButtons have tooltips', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignToVoiceScreen()));

    // Verify 'More options' tooltip (AppBar action)
    expect(find.byTooltip('More options'), findsOneWidget);

    // Verify 'Copy transcript' tooltip
    expect(find.byTooltip('Copy transcript'), findsOneWidget);

    // Verify 'Download transcript' tooltip
    expect(find.byTooltip('Download transcript'), findsOneWidget);
  });
}
