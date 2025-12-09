import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:poc_app/core/api_service.dart';
import 'package:poc_app/pages/splash_page.dart';

class MockApiService implements ApiService {
  final AppVersionInfo response;
  const MockApiService(this.response);

  @override
  Future<AppVersionInfo> checkAppVersion() => Future.value(response);
}

class FakeHomePage extends StatelessWidget {
  const FakeHomePage({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Home Page')));
}

void main() {
  testWidgets('SplashPage shows update bottom sheet on force update', (WidgetTester tester) async {
    final mockApiService = MockApiService(AppVersionInfo(UpdateStatus.forceUpdate));
    await tester.pumpWidget(MaterialApp(home: SplashPage(apiService: mockApiService)));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.byType(Lottie), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    expect(find.text('New version available'), findsOneWidget);
    expect(find.text('Update Now'), findsOneWidget);
  });

  testWidgets('SplashPage navigates to home on latest version', (WidgetTester tester) async {
    final mockApiService = MockApiService(AppVersionInfo(UpdateStatus.latest));
    await tester.pumpWidget(MaterialApp(home: SplashPage(apiService: mockApiService, home: const FakeHomePage())));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pump();
    expect(find.byType(Lottie), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(FakeHomePage), findsOneWidget);
  });
}
