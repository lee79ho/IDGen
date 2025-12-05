// This is a basic Flutter widget test.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_app/main.dart';

void main() {
  testWidgets('Splash screen shows a flutter logo', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the splash screen is shown.
    expect(find.byType(FlutterLogo), findsOneWidget);
  });
}
