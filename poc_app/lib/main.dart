import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:poc_app/pages/splash_page.dart';

// TODO: Replace with your actual Kakao native app key from the Kakao Developer console.
const String _kakaoNativeAppKey = 'YOUR_NATIVE_APP_KEY_PLACEHOLDER';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the Kakao SDK before running the app.
  // Make sure to replace `_kakaoNativeAppKey` with your actual key.
  KakaoSdk.init(nativeAppKey: _kakaoNativeAppKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
    );
  }
}
