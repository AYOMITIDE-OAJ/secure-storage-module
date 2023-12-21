
import 'dart:convert';

import 'flutter_secure_storage_module_platform_interface.dart';
import 'crypto_service.dart';

class FlutterSecureStorageModule {


  Future<String?> getPlatformVersion() {
    return FlutterSecureStorageModulePlatform.instance.getPlatformVersion();
  }

  Future<void> write(String key, String value) async {

    final encryptedBytes = CryptoService.encrypt(utf8.encode(value));

    final encryptedString = base64Encode(encryptedBytes);

    await FlutterSecureStorageModulePlatform.instance.write(key, encryptedString);
  }

  Future<String?> read(String key) async {
    final encrypted = await FlutterSecureStorageModulePlatform.instance.read(key);
    if(encrypted == null) return null;
    
    final encrytedBytes = utf8.encode(encrypted);

    final decrypted = CryptoService.decrypt(encrytedBytes);  
    return utf8.decode(decrypted);
  }

  Future<void> delete(String key){
    return FlutterSecureStorageModulePlatform.instance.delete(key);
  }

  Future<bool> containsKey(String key){
    return FlutterSecureStorageModulePlatform.instance.containsKey(key).then((contains) {
      return contains ?? false;
    });
  }
}
