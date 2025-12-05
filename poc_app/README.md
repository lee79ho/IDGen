# poc_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Social Login Configuration

To enable social login functionalities, you need to replace the placeholder values in the following files with your actual keys and settings from the respective developer consoles.

### 1. Kakao Login

- **File:** `lib/main.dart`
  - Replace `YOUR_NATIVE_APP_KEY_PLACEHOLDER` with your Kakao native app key.
- **File:** `android/app/src/main/AndroidManifest.xml`
  - In the `AuthCodeHandlerActivity` intent-filter, replace `kakaoYOUR_NATIVE_APP_KEY_PLACEHOLDER` with your Kakao native app key prefixed with "kakao".
- **File:** `ios/Runner/Info.plist`
  - In the `CFBundleURLSchemes` array, replace `kakaoYOUR_NATIVE_APP_KEY_PLACEHOLDER` with your Kakao native app key prefixed with "kakao".

### 2. Naver Login

- **File:** `android/app/src/main/AndroidManifest.xml`
  - Replace `YOUR_NAVER_CLIENT_ID_PLACEHOLDER` with your Naver client ID.
  - Replace `YOUR_NAVER_CLIENT_SECRET_PLACEHOLDER` with your Naver client secret.
  - Replace `YOUR_NAVER_CLIENT_NAME_PLACEHOLDER` with your Naver client name.
- **File:** `ios/Runner/Info.plist`
  - In the `CFBundleURLSchemes` array, replace `YOUR_NAVER_URL_SCHEME_PLACEHOLDER` with your Naver URL scheme.

### 3. Apple Login

- **File:** `ios/Runner/AppDelegate.swift`
  - Follow the instructions in the comment at the top of the file to enable the "Sign in with Apple" capability in your Xcode project.
