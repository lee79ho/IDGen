import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:poc_app/core/auth_manager.dart';

class WebShellPage extends StatefulWidget {
  const WebShellPage({super.key});

  @override
  _WebShellPageState createState() => _WebShellPageState();
}

class _WebShellPageState extends State<WebShellPage> {
  final AuthManager _authManager = AuthManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USIMSA'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                _showLoginDialog(context);
              },
            ),
          ],
        ),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri('https://usimsa.com')),
      ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _handleLogin(context, _authManager.loginWithKakao),
                  child: const Text('Login with Kakao'),
                ),
                ElevatedButton(
                  onPressed: () => _handleLogin(context, _authManager.loginWithNaver),
                  child: const Text('Login with Naver'),
                ),
                ElevatedButton(
                  onPressed: () => _handleLogin(context, _authManager.loginWithApple),
                  child: const Text('Login with Apple'),
                ),
                ElevatedButton(
                  onPressed: () => _handleLogin(context, _authManager.loginWithUsimsa),
                  child: const Text('Login with Usimsa'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleLogin(BuildContext context, Future<String> Function() loginMethod) async {
    final result = await loginMethod();
    Navigator.pop(context); // Close the dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
  }
}
