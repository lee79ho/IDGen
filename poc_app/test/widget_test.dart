import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:poc_app/core/api_service.dart';
import 'package:poc_app/pages/splash_page.dart';

// A mock implementation of ApiService for testing purposes.
class MockApiService implements ApiService {
  final AppVersionInfo response;

  const MockApiService(this.response);

  @override
  Future<AppVersionInfo> checkAppVersion() {
    return Future.value(response);
  }
}

// A simple placeholder widget to act as the home page for testing navigation.
class FakeHomePage extends StatelessWidget {
  const FakeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

void main() {
  testWidgets('SplashPage shows update bottom sheet on force update', (WidgetTester tester) async {
    // Mock the ApiService to return a force update status
    final mockApiService = MockApiService(AppVersionInfo(
      UpdateStatus.forceUpdate,
      'https://via.placeholder.com/150',
    ));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SplashPage(apiService: mockApiService),
    ));

    // The first pump will show the loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump the widget again to process the future from the api service
    await tester.pump();

    // Now the image should be visible
    expect(find.byType(Image), findsOneWidget);

    // Wait for the delay and the bottom sheet to appear
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('New version available'), findsOneWidget);
    expect(find.text('Update Now'), findsOneWidget);
  });

  testWidgets('SplashPage navigates to home on latest version', (WidgetTester tester) async {
    // Mock the ApiService to return a latest version status
    final mockApiService = MockApiService(AppVersionInfo(
      UpdateStatus.latest,
      'https://via.placeholder.com/150',
    ));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: SplashPage(apiService: mockApiService, home: const FakeHomePage()),
    ));

    // The first pump will show the loading indicator
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Pump the widget again to process the future from the api service
    await tester.pump();

    // Now the image should be visible
    expect(find.byType(Image), findsOneWidget);

    // Wait for the delay and navigation to happen
    await tester.pump(const Duration(seconds: 2));

    // Pump again to complete the navigation transition
    await tester.pumpAndSettle();

    // After navigation, the FakeHomePage should be visible
    expect(find.byType(FakeHomePage), findsOneWidget);
  });
}
