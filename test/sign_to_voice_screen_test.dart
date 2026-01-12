
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('Record button has correct semantics', (WidgetTester tester) async {
    // Build the SignToVoiceScreen
    await tester.pumpWidget(const MaterialApp(
      home: SignToVoiceScreen(),
    ));

    // Verify the record button exists and has correct semantics
    // We can check properties of the Semantics widget directly via find.byType(Semantics)
    // and filtering.

    final semanticsFinder = find.descendant(
      of: find.byType(Column),
      matching: find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.label == 'Record'),
    );

    expect(semanticsFinder, findsOneWidget);

    final semanticsWidget = tester.widget<Semantics>(semanticsFinder);
    expect(semanticsWidget.properties.button, isTrue);
  });
}
