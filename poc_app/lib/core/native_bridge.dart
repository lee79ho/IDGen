import 'dart:async';
import 'package:flutter/services.dart';

class NativeBridge {
  static const MethodChannel _channel = MethodChannel('app/native/method');

  // Singleton instance
  static final NativeBridge _instance = NativeBridge._internal();

  factory NativeBridge() {
    return _instance;
  }

  NativeBridge._internal();

  Future<Map<String, dynamic>> startSocialLogin(String provider) async {
    try {
      final result = await _channel.invokeMethod('startSocialLogin', {
        'provider': provider,
      });
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      // Handle platform exceptions (e.g., method not implemented)
      print("Failed to start social login: '${e.message}'.");
      return {'status': 'error', 'error': e.message};
    }
  }

  Future<Map<String, dynamic>> startPayment(String provider, String orderId, double amount) async {
    try {
      final result = await _channel.invokeMethod('startPayment', {
        'provider': provider,
        'orderId': orderId,
        'amount': amount,
      });
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      // Handle platform exceptions
      print("Failed to start payment: '${e.message}'.");
      return {'status': 'error', 'error': e.message};
    }
  }
}
