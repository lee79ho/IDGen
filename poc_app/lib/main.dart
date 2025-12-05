import 'package:flutter/material.dart';
import 'package:poc_app/core/native_bridge.dart';

void main() {
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

  Future<void> _startSocialLogin(String provider) async {
    final result = await _nativeBridge.startSocialLogin(provider);
    setState(() {
      _result = result.toString();
    });
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
              onPressed: () => _startSocialLogin('google'),
              child: const Text('Login with Google'),
            ),
            ElevatedButton(
              onPressed: () => _startSocialLogin('apple'),
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
