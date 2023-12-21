import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_secure_storage_module_platform_interface.dart';


class MethodChannelFlutterSecureStorageModule extends FlutterSecureStorageModulePlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_secure_storage_module');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> write(String key, String value) async {
    await methodChannel.invokeListMethod<void>('write', {'key': key, 'value': value});
  }

  @override
  Future<String?> read(String key) async {
    return await methodChannel.invokeMethod<String>('read', {'key': key});
  }

  @override
  Future<void> delete(String key) async {
    await methodChannel.invokeMethod<void>('delete', {'key': key});
  }

  @override
  Future<bool> containsKey(String key) async {
    final contains = await methodChannel.invokeMethod<bool?>('containsKey', {'key': key});
    return contains ?? false;
  }

}
