import 'dart:math';

enum UpdateStatus {
  latest,
  forceUpdate,
  optionalUpdate,
}

class AppVersionInfo {
  final UpdateStatus status;

  const AppVersionInfo(this.status);
}

class ApiService {
  const ApiService();

  Future<AppVersionInfo> checkAppVersion() async {
    await Future.delayed(const Duration(seconds: 1));
    final statuses = [
      UpdateStatus.latest,
      UpdateStatus.forceUpdate,
      UpdateStatus.optionalUpdate
    ];
    final status = statuses[Random().nextInt(statuses.length)];
    return AppVersionInfo(status);
  }
}
