import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen has accessible recording button', (WidgetTester tester) async {
    // Build the SignToVoiceScreen widget.
    await tester.pumpWidget(const MaterialApp(
      home: SignToVoiceScreen(),
    ));

    // Verify the recording button is present.
    // We can look for the Semantics widget directly or properties.
    // The label we added is 'Start recording'.

    // Find the semantics handle.
    final handle = tester.ensureSemantics();

    // Verify that a widget with the label 'Start recording' exists.
    expect(find.bySemanticsLabel('Start recording'), findsOneWidget);

    // Verify it is a button.
    final semanticsFinder = find.byWidgetPredicate((widget) {
      if (widget is Semantics) {
        return widget.properties.label == 'Start recording' && widget.properties.button == true;
      }
      return false;
    });

    expect(semanticsFinder, findsOneWidget);

    // Verify the hint is present (might need to check properties specifically if find.byTooltip/etc doesn't work for hints)
    final semanticWidget = tester.widget<Semantics>(semanticsFinder);
    expect(semanticWidget.properties.hint, 'Double tap to begin capturing sign language');

    // Clean up semantics handle
    handle.dispose();
  });
}
