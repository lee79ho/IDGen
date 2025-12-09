import 'package:flutter/services.dart';

class NativeBridge {
  static const MethodChannel _channel = MethodChannel('app/native/method');

  Future<Map<String, dynamic>> startPayment({
    required String provider,
    required String orderId,
    required double amount,
  }) async {
    try {
      final result = await _channel.invokeMethod('startPayment', {
        'provider': provider,
        'orderId': orderId,
        'amount': amount,
      });
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      print("Failed to start payment: '${e.message}'.");
      return {'status': 'error', 'message': e.message};
    }
  }
}
