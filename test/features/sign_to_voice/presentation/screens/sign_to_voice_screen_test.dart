import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen has accessible recording button', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(
      home: SignToVoiceScreen(),
    ));

    // Verify presence of Semantics for recording button using properties
    final semanticsFinder = find.byWidgetPredicate((widget) {
      if (widget is Semantics) {
        // Access properties through semantic properties map if available or check specific fields
        // In Flutter, Semantics widget properties are passed to the render object, but we can check the properties directly
        // However, the test error suggests 'label' and 'button' are not direct properties of Semantics widget class in this version or context?
        // Ah, Semantics widget stores them in `properties`. Let's check `properties.label`
        return widget.properties.label == 'Start recording' && widget.properties.button == true;
      }
      return false;
    });

    expect(semanticsFinder, findsOneWidget);

    // Verify tooltips
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.byTooltip('More options'), findsOneWidget);
    expect(find.byTooltip('Copy transcript'), findsOneWidget);
    expect(find.byTooltip('Download transcript'), findsOneWidget);
  });
}
