import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:poc_app/core/native_bridge.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'YOUR_NATIVE_APP_KEY'); // Replace with your actual Kakao native app key
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NativeBridge _nativeBridge = NativeBridge();
  String _result = 'No result yet';

  Future<void> _loginWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      setState(() {
        _result = 'Naver Login Success: ${result.account.email}';
      });
    } catch (e) {
      setState(() {
        _result = 'Naver Login Error: $e';
      });
    }
  }

  Future<void> _loginWithKakao() async {
    try {
      final bool isInstalled = await isKakaoTalkInstalled();
      final token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      final user = await UserApi.instance.me();
      setState(() {
        _result = 'Kakao Login Success: ${user.kakaoAccount?.email}';
      });
    } catch (e) {
      setState(() {
        _result = 'Kakao Login Error: $e';
      });
    }
  }

  Future<void> _loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      setState(() {
        _result = 'Apple Login Success: ${credential.email}';
      });
    } catch (e) {
      setState(() {
        _result = 'Apple Login Error: $e';
      });
    }
  }

  Future<void> _startPayment(String provider) async {
    final result = await _nativeBridge.startPayment(provider, 'order_123', 9.99);
    setState(() {
      _result = result.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Bridge POC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _loginWithNaver,
              child: const Text('Login with Naver'),
            ),
            ElevatedButton(
              onPressed: _loginWithKakao,
              child: const Text('Login with Kakao'),
            ),
            ElevatedButton(
              onPressed: _loginWithApple,
              child: const Text('Login with Apple'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _startPayment('toss'),
              child: const Text('Pay with Toss'),
            ),
            ElevatedButton(
              onPressed: () => _startPayment('kakaopay'),
              child: const Text('Pay with KakaoPay'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Result:',
            ),
            Text(
              _result,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
