import 'package:dio/dio.dart';
import 'package:poc_app/core/env_const.dart';
import 'package:poc_app/models/version_check_response.dart';

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
  final Dio _dio;

  ApiService({Dio? dio}) : _dio = dio ?? Dio();

  Future<AppVersionInfo> checkAppVersion() async {
    try {
      final response = await _dio.get("${EnvConst.userApiUrl}/api/v1/version");
      final data = GetVersionCheckResponse.fromJson(response.data);
      return AppVersionInfo(_mapUpdateStatus(data.updateType));
    } catch (e) {
      print('Failed to check app version: $e');
      return const AppVersionInfo(UpdateStatus.latest);
    }
  }

  UpdateStatus _mapUpdateStatus(String updateType) {
    switch (updateType.toUpperCase()) {
      case 'FORCE':
        return UpdateStatus.forceUpdate;
      case 'OPTIONAL':
        return UpdateStatus.optionalUpdate;
      default:
        return UpdateStatus.latest;
    }
  }
}
