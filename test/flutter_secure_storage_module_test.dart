import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage_module/flutter_secure_storage_module.dart';
import 'package:flutter_secure_storage_module/flutter_secure_storage_module_platform_interface.dart';
import 'package:flutter_secure_storage_module/flutter_secure_storage_module_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSecureStorageModulePlatform
    with MockPlatformInterfaceMixin
    implements FlutterSecureStorageModulePlatform {

    @override
    Future<void> write(String key, String value) async {}

    @override 
    Future<String?> read(String key) async => null;
    
    @override
    Future<void> delete(String key) async {}

    @override
    Future<bool> containsKey(String key) async => false;

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSecureStorageModulePlatform initialPlatform = FlutterSecureStorageModulePlatform.instance;

  test('$MethodChannelFlutterSecureStorageModule is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSecureStorageModule>());
  });

  test('getPlatformVersion', () async {
    FlutterSecureStorageModule flutterSecureStorageModulePlugin = FlutterSecureStorageModule();
    MockFlutterSecureStorageModulePlatform fakePlatform = MockFlutterSecureStorageModulePlatform();
    FlutterSecureStorageModulePlatform.instance = fakePlatform;

    expect(await flutterSecureStorageModulePlugin.getPlatformVersion(), '42');
  });
}
