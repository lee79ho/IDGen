package com.gadgetkorea.usimsa

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app/native/method"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "startPayment") {
                val provider = call.argument<String>("provider")
                val orderId = call.argument<String>("orderId")
                val amount = call.argument<Double>("amount")
                result.success(mapOf(
                    "status" to "success",
                    "orderId" to orderId,
                    "provider" to provider,
                    "amount" to amount,
                    "platform" to "android"
                ))
            } else {
                result.notImplemented()
            }
        }
    }
}
