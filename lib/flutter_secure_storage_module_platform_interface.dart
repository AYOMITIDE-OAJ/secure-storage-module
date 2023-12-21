import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_secure_storage_module_method_channel.dart';

abstract class FlutterSecureStorageModulePlatform extends PlatformInterface {
  /// Constructs a FlutterSecureStorageModulePlatform.
  FlutterSecureStorageModulePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSecureStorageModulePlatform _instance = MethodChannelFlutterSecureStorageModule();

  static FlutterSecureStorageModulePlatform get instance => _instance;


  static set instance(FlutterSecureStorageModulePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete (String key);
  Future<bool?> containsKey(String key);

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
