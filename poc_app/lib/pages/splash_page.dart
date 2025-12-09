import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:poc_app/core/api_service.dart';
import 'package:poc_app/pages/web_shell_page.dart';
import 'package:poc_app/widgets/update_bottom_sheet.dart';

class SplashPage extends StatefulWidget {
  final ApiService apiService;
  final Widget? home;

  SplashPage({
    super.key,
    ApiService? apiService,
    this.home,
  }) : apiService = apiService ?? ApiService();

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    final info = await widget.apiService.checkAppVersion();

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    switch (info.status) {
      case UpdateStatus.latest:
        _navigateToHome();
        break;
      case UpdateStatus.forceUpdate:
      case UpdateStatus.optionalUpdate:
        showUpdateBottomSheet(context, info.status, () {
          if (info.status == UpdateStatus.optionalUpdate) {
            _navigateToHome();
          }
        });
        break;
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget.home ?? const WebShellPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Lottie.asset(
                'assets/lottie/loading.json',
                width: 200,
                height: 200,
              ),
      ),
    );
  }
}
