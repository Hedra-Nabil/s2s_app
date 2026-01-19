import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s2s_app/features/video_to_avatar/presentation/screens/video_to_avatar_screen.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  testWidgets('VideoToAvatarScreen renders and checks for tooltips and semantics',
      (WidgetTester tester) async {
    // Build the VideoToAvatarScreen widget.
    await tester.pumpWidget(const MaterialApp(
      home: VideoToAvatarScreen(),
    ));

    // Allow animations and async operations to settle
    await tester.pumpAndSettle();

    // Verify that the screen title is present
    expect(find.text('Video to Avatar'), findsOneWidget);

    // Check for AppBar leading button (Back)
    final backButtonFinder = find.widgetWithIcon(IconButton, Icons.arrow_back);
    expect(backButtonFinder, findsOneWidget);
    final backButton = tester.widget<IconButton>(backButtonFinder);

    // Check for AppBar actions button (More options)
    final moreButtonFinder = find.widgetWithIcon(IconButton, Icons.more_vert);
    expect(moreButtonFinder, findsOneWidget);
    final moreButton = tester.widget<IconButton>(moreButtonFinder);

    // Check for Close button in progress card
    final closeButtonFinder = find.widgetWithIcon(IconButton, Icons.close);
    expect(closeButtonFinder, findsOneWidget);
    final closeButton = tester.widget<IconButton>(closeButtonFinder);

    // Verify Tooltips are present
    expect(backButton.tooltip, equals('Back'));
    expect(moreButton.tooltip, equals('More options'));
    expect(closeButton.tooltip, equals('Cancel upload'));

    // Check Semantics for progress indicator
    final progressFinder = find.byType(LinearProgressIndicator);
    expect(progressFinder, findsOneWidget);

    // Find the Semantics widget wrapping the LinearProgressIndicator
    final semanticsFinder = find.ancestor(
      of: progressFinder,
      matching: find.byType(Semantics),
    ).first;
    expect(semanticsFinder, findsOneWidget);

    final semantics = tester.widget<Semantics>(semanticsFinder);
    expect(semantics.properties.label, equals('Upload progress: 85%'));
  });
}

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return _TestHttpClient();
  }
}

class _TestHttpClient implements HttpClient {
  @override
  Future<HttpClientRequest> getUrl(Uri url) async {
    return _TestHttpClientRequest();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

class _TestHttpClientRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async {
    return _TestHttpClientResponse();
  }

  @override
  HttpHeaders get headers => _TestHttpHeaders();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

class _TestHttpHeaders implements HttpHeaders {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

class _TestHttpClientResponse implements HttpClientResponse {
  @override
  int get statusCode => 200;

  @override
  int get contentLength => kTransparentImage.length;

  @override
  HttpClientResponseCompressionState get compressionState => HttpClientResponseCompressionState.notCompressed;

  @override
  Future<S> drain<S>([S? futureValue]) async {
      return futureValue as S;
  }

  @override
  StreamSubscription<List<int>> listen(void Function(List<int> event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return Stream<List<int>>.fromIterable([kTransparentImage]).listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return null;
  }
}

// Minimal transparent 1x1 GIF
const List<int> kTransparentImage = <int>[
  0x47, 0x49, 0x46, 0x38, 0x39, 0x61, 0x01, 0x00,
  0x01, 0x00, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
  0x00, 0x00, 0x00, 0x21, 0xf9, 0x04, 0x01, 0x00,
  0x00, 0x00, 0x00, 0x2c, 0x00, 0x00, 0x00, 0x00,
  0x01, 0x00, 0x01, 0x00, 0x00, 0x02, 0x02, 0x44,
  0x01, 0x00, 0x3b
];
