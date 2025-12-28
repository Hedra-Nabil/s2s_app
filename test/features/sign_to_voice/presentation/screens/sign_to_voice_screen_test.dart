import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen has accessible record button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: SignToVoiceScreen()));

    // Verify Tooltip exists with correct message
    final anyTooltip = find.byType(Tooltip);
    expect(anyTooltip, findsOneWidget);
    final tooltipWidget = tester.widget<Tooltip>(anyTooltip.first);
    expect(tooltipWidget.message, 'Start recording');

    // Verify Semantics exists with correct label and properties
    final specificSemantics = find.byWidgetPredicate((widget) =>
      widget is Semantics &&
      widget.properties.label == 'Start recording' &&
      widget.properties.button == true
    );
    expect(specificSemantics, findsOneWidget);

    // Verify InkWell exists for touch feedback
    expect(find.byType(InkWell), findsWidgets);
  });
}
