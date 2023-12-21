import Flutter
import UIKit

public class FlutterSecureStorageModulePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_secure_storage_module", binaryMessenger: registrar.messenger())
    let instance = FlutterSecureStorageModulePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "write":
      handleWrite(call, result)
    case "read":
      handleRead(call, result)
    case "delete":
      handleDelete(call, result)
    case "containskey":
      handleContainsKey(call, result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
