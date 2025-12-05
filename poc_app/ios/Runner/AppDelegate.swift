import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "app/native/method",
                                              binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if (call.method == "startPayment") {
        guard let args = call.arguments as? [String: Any],
              let orderId = args["orderId"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "orderId is required", details: nil))
          return
        }
        // In a real app, you'd integrate the respective payment SDKs here.
        // For this POC, we'll just return a dummy success response.
        result(["status": "success", "orderId": orderId, "platform": "ios"])
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
