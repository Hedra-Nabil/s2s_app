import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';

void main() {
  testWidgets('SignToVoiceScreen has accessibility improvements', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: SignToVoiceScreen()));

    // 1. Check for Tooltips on IconButtons
    // We expect at least 4 Tooltips now.
    final tooltipFinder = find.byType(Tooltip);
    expect(tooltipFinder, findsAtLeastNWidgets(4));

    // Verify specific tooltips exist
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.byTooltip('More options'), findsOneWidget);
    expect(find.byTooltip('Copy transcript'), findsOneWidget);
    expect(find.byTooltip('Download transcript'), findsOneWidget);

    // 2. Check for the Record button semantics
    // It should now have a label 'Start recording' and be a button.

    // Verify Semantics widget is present
    expect(find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.label == 'Start recording'), findsOneWidget);

    // Verify semantic node
    final semanticFinder = find.bySemanticsLabel('Start recording');
    expect(semanticFinder, findsOneWidget);

    // Verify it is a button
    final semanticsHandle = tester.ensureSemantics();
    final node = tester.getSemantics(semanticFinder);
    expect(node.hasFlag(SemanticsFlag.isButton), isTrue);
    semanticsHandle.dispose();
  });
}
