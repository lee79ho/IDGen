import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthManager {
  Future<String> loginWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      return 'Naver Login Success: ${result.account.email}';
    } catch (e) {
      return 'Naver Login Error: $e';
    }
  }

  Future<String> loginWithKakao() async {
    try {
      final bool isInstalled = await isKakaoTalkInstalled();
      final token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      final user = await UserApi.instance.me();
      return 'Kakao Login Success: ${user.kakaoAccount?.email}';
    } catch (e) {
      return 'Kakao Login Error: $e';
    }
  }

  Future<String> loginWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      return 'Apple Login Success: ${credential.email}';
    } catch (e) {
      return 'Apple Login Error: $e';
    }
  }

  Future<String> loginWithUsimsa() async {
    // This is a placeholder for the custom Usimsa login.
    // In a real app, this would involve a custom login flow.
    return 'Usimsa Login (Not Implemented)';
  }
}
