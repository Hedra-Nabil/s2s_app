import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/sign_to_voice/presentation/screens/sign_to_voice_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('SignToVoiceScreen has accessible record button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We need to wrap it in MaterialApp for localization and theme.
    await tester.pumpWidget(
      const MaterialApp(
        home: SignToVoiceScreen(),
      ),
    );

    // Find the record button. Currently it's a Container inside a GestureDetector.
    // We can find it by the text below it "Tap to start recording" and looking for the widget above it,
    // or by the red border decoration.

    // Let's try to find it by the specific decoration or structure.
    // The inner container has a red circle.
    final redInnerCircleFinder = find.byWidgetPredicate((widget) {
      if (widget is Container && widget.decoration is BoxDecoration) {
        final decoration = widget.decoration as BoxDecoration;
        return decoration.shape == BoxShape.circle && decoration.color == Colors.red;
      }
      return false;
    });

    expect(redInnerCircleFinder, findsOneWidget);

    // Now find the interactive parent (GestureDetector currently)
    final gestureDetectorFinder = find.ancestor(
      of: redInnerCircleFinder,
      matching: find.byType(GestureDetector),
    );

    // After refactor, it might be an InkWell which is a GestureDetector internally or behaves similarly,
    // but we are checking semantics mostly.

    // Expect to find semantics with label "Start recording"
    // Using predicate since bySemanticsLabel can be finicky with direct Semantics widgets in some test environments
    final specificSemantics = find.byWidgetPredicate((widget) {
      return widget is Semantics && widget.properties.label == 'Start recording';
    });

    expect(specificSemantics, findsOneWidget);

    // Also verifying tooltips on other buttons
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(find.byTooltip('More options'), findsOneWidget);
    expect(find.byTooltip('Copy transcript'), findsOneWidget);
    expect(find.byTooltip('Download audio'), findsOneWidget);
  });
}
