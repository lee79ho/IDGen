import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthManager {
  Future<void> signInWithKakao() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      print('Kakao login success');
    } catch (error) {
      print('Kakao login failed: $error');
    }
  }

  Future<void> signInWithNaver() async {
    try {
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      if (result.status == NaverLoginStatus.loggedIn) {
        print('Naver login success: ${result.account.email}');
      }
    } catch (error) {
      print('Naver login failed: $error');
    }
  }

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print('Apple login success: ${credential.userIdentifier}');
    } catch (error) {
      print('Apple login failed: $error');
    }
  }

  Future<void> signInWithUsimsa() async {
    // Placeholder for custom login
    print('Usimsa login tapped');
  }
}
