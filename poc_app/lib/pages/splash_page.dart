import 'package:flutter/material.dart';
import 'package:poc_app/core/api_service.dart';
import 'package:poc_app/pages/web_shell_page.dart';
import 'package:poc_app/widgets/update_bottom_sheet.dart';

class SplashPage extends StatefulWidget {
  final ApiService apiService;
  final Widget? home; // Add this for testing purposes

  const SplashPage({
    super.key,
    this.apiService = const ApiService(),
    this.home,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  AppVersionInfo? _appVersionInfo;
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
      _appVersionInfo = info;
      _isLoading = false;
    });

    // Allow the splash image to be visible for a moment before acting.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    switch (info.status) {
      case UpdateStatus.latest:
        _navigateToHome();
        break;
      case UpdateStatus.forceUpdate:
      case UpdateStatus.optionalUpdate:
        showUpdateBottomSheet(context, info.status, () {
          print("Update Now pressed");
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
            : (_appVersionInfo?.imageUrl != null
                ? Image.network(
                    _appVersionInfo!.imageUrl!,
                    width: 300,
                    height: 300,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 150),
                  )
                : const FlutterLogo(size: 150)),
      ),
    );
  }
}
