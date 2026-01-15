import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen accessibility test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: SignToVoiceScreen(),
    ));

    // 1. Check for Recording Button Accessibility
    // The recording button should have a semantic label "Start recording" and be identified as a button.
    // Currently it is just a GestureDetector with no semantics.
    final recordingButtonFinder = find.bySemanticsLabel('Start recording');

    // We expect this to fail initially
    if (tester.any(recordingButtonFinder)) {
        // If it exists, check if it has button trait
        final semantics = tester.getSemantics(recordingButtonFinder);
        expect(semantics.hasFlag(SemanticsFlag.isButton), isTrue, reason: 'Recording button should have button semantic trait');
    } else {
        // Initial state: expect not to find it, but for the test to be useful for verification later,
        // we write the expectation.
        expect(recordingButtonFinder, findsOneWidget, reason: 'Should have a button with label "Start recording"');
    }

    // 2. Check for Tooltips on IconButtons
    // Helper to check tooltip
    void checkTooltip(IconData icon, String message) {
      final iconFinder = find.byIcon(icon);
      expect(iconFinder, findsOneWidget);

      // IconButton wraps the icon. We look for a Tooltip widget which IconButton uses internally
      // when tooltip is provided, OR we check semantics.
      // Flutter IconButton with tooltip adds a semantic label.
      final tooltipFinder = find.byTooltip(message);
      expect(tooltipFinder, findsOneWidget, reason: 'Icon ${icon.toString()} should have tooltip "$message"');
    }

    checkTooltip(Icons.arrow_back, 'Back');
    checkTooltip(Icons.more_vert, 'More options');
    checkTooltip(Icons.copy, 'Copy transcript');
    checkTooltip(Icons.download, 'Download transcript');
  });
}
