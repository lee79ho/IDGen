# POC App

This is a proof-of-concept Flutter application.

## Native Project Configuration

To enable all features, you need to configure the native Android and iOS projects.

### Android

File: `android/app/src/main/AndroidManifest.xml`

1.  **Kakao Login:** Replace `kakaoYOUR_NATIVE_APP_KEY_PLACEHOLDER` with your actual Kakao native app key.
2.  **Naver Login:** Replace the placeholder values for `com.naver.sdk.clientId`, `com.naver.sdk.clientSecret`, and `com.naver.sdk.clientName`.

File: `lib/main.dart`

1.  **Kakao SDK:** Replace `YOUR_KAKAO_NATIVE_APP_KEY_PLACEHOLDER` with your Kakao native app key to initialize the SDK.

### iOS

File: `ios/Runner/Info.plist`

1.  **Kakao Login:** Replace `kakaoYOUR_KAKAO_NATIVE_APP_KEY_PLACEHOLDER` with your actual Kakao native app key.
2.  **Naver Login:** Replace placeholders for `YOUR_NAVER_URL_SCHEME_PLACEHOLDER`, `NaverConsumerKey`, `NaverConsumerSecret`, and `NaverAppName`.

**Xcode Configuration:**

1.  Open the `ios` directory in Xcode.
2.  Select the `Runner` target.
3.  Go to the "Signing & Capabilities" tab.
4.  Click `+ Capability` and add "Sign in with Apple".
