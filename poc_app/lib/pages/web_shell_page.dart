import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:poc_app/core/auth_manager.dart';
import 'package:poc_app/core/native_bridge.dart';

class WebShellPage extends StatefulWidget {
  const WebShellPage({super.key});

  @override
  State<WebShellPage> createState() => _WebShellPageState();
}

class _WebShellPageState extends State<WebShellPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthManager _authManager = AuthManager();
  final NativeBridge _nativeBridge = NativeBridge();

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(onPressed: _authManager.signInWithKakao, child: const Text('Kakao Login')),
              ElevatedButton(onPressed: _authManager.signInWithNaver, child: const Text('Naver Login')),
              ElevatedButton(onPressed: _authManager.signInWithApple, child: const Text('Apple Login')),
              ElevatedButton(onPressed: _authManager.signInWithUsimsa, child: const Text('Usimsa Login')),
            ],
          ),
        );
      },
    );
  }

  void _startMockPayment() async {
    final result = await _nativeBridge.startPayment(
      provider: 'toss',
      orderId: 'mock_order_123',
      amount: 1000.0,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment result: $result')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Usimsa'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Login'),
              onTap: _showLoginDialog,
            ),
            ListTile(
              title: const Text('Start Mock Payment'),
              onTap: _startMockPayment,
            )
          ],
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri('https://usimsa.com')),
      ),
    );
  }
}
