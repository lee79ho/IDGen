// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:poc_app/main.dart';

void main() {
  testWidgets('POC UI smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial result text is "No result yet".
    expect(find.text('No result yet'), findsOneWidget);

    // Verify that the login and payment buttons are present.
    expect(find.text('Login with Naver'), findsOneWidget);
    expect(find.text('Login with Kakao'), findsOneWidget);
    expect(find.text('Login with Apple'), findsOneWidget);
    expect(find.text('Pay with Toss'), findsOneWidget);
    expect(find.text('Pay with KakaoPay'), findsOneWidget);
  });
}
