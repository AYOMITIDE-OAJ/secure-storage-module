import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage_module/crypto_service.dart';

void main(){
  group('CryptoService Tests', () {
    test('Encryption and Decryption Test', () {
      final originalData = 'Sensitive information';
      final utf8Data = utf8.encode(originalData);

      // Encrypt the data
      final encryptedData = CryptoService.encrypt(utf8Data);

      // Decrypt the data
      final decryptedData = CryptoService.decrypt(encryptedData);
      final decryptedString = utf8.decode(decryptedData);

      expect(decryptedString, originalData);
    });

    test('Encryption and Decryption with Different Data Types Test', () {
      final originalData = Uint8List.fromList([1, 2, 3, 4, 5]);
      
      // Encrypt the data
      final encryptedData = CryptoService.encrypt(originalData);
      
      // Decrypt the data
      final decryptedData = CryptoService.decrypt(encryptedData);

      expect(decryptedData, originalData);
    });

  });
}