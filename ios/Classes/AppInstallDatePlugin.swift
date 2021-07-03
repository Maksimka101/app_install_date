import Flutter
import UIKit

public class AppInstallDatePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "app_install_date", binaryMessenger: registrar.messenger())
    let instance = AppInstallDatePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  /// Already implemented on dart side
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      default:
        result(FlutterMethodNotImplemented)
    }
  }
}
