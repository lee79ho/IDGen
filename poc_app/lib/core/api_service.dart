import 'dart:math';

// Represents the result of the app version check.
enum UpdateStatus {
  latest,
  forceUpdate,
  optionalUpdate,
}

/// A data class to hold the app version information.
class AppVersionInfo {
  final UpdateStatus status;
  final String? imageUrl;

  const AppVersionInfo(this.status, [this.imageUrl]);
}

class ApiService {
  const ApiService();
  /// Simulates a network call to check the app version.
  ///
  /// In a real application, this method would make an HTTP request to a server,
  /// sending the current app version and returning the update status.
  ///
  /// For this POC, it randomly returns one of the [UpdateStatus] values
  /// after a short delay to mimic network latency.
  Future<AppVersionInfo> checkAppVersion() async {
    // Simulate network latency
    await Future.delayed(const Duration(seconds: 1));

    // Randomly return one of the update statuses for demonstration purposes.
    final statuses = [
      UpdateStatus.latest,
      UpdateStatus.forceUpdate,
      UpdateStatus.optionalUpdate
    ];
    final status = statuses[Random().nextInt(statuses.length)];

    return AppVersionInfo(status);
  }
}
