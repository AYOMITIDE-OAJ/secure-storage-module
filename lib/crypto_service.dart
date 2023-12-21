import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class CryptoService {

  static final Uint8List _key = Uint8List.fromList(utf8.encode('YOUR_SECRET_KEY')); // Replace with your secret key

  static final CBCBlockCipher _cipher = CBCBlockCipher(AESFastEngine());
  static Uint8List generateRandomIV(){
    final secureRandom = SecureRandom('AES/CTR/AUTO-SEED-PRNG');
    final iv = Uint8List(16);
    secureRandom.nextBytes(iv as int);
    return iv;
  }




  static Uint8List encrypt(Uint8List data) {
    final iv = generateRandomIV();
    final params = ParametersWithIV(KeyParameter(_key), iv);
    _cipher.init(true, params);// true for encryption

    final paddedData = _padData(data);
    final encrypted = _cipher.process(paddedData);

    return Uint8List.fromList([...iv, ...encrypted]);
  }

  static Uint8List decrypt(Uint8List encryptedData) {
    final iv = encryptedData.sublist(0, 16);
    final params = ParametersWithIV(KeyParameter(_key), iv);
    _cipher.init(false, params);

    final decrypted = _cipher.process(encryptedData.sublist(16));
    return _unpadData(decrypted);
  }

  static Uint8List _padData(Uint8List data) {
    final blockSize = 16; //AES block size
    final padLength = blockSize - (data.length % blockSize);
    final paddedData = Uint8List(data.length + padLength)
      ..setAll(0, data)
      ..fillRange(data.length, data.length + padLength, padLength);
    return paddedData;
  }

  static Uint8List _unpadData(Uint8List data) {
    final padLength = data.last;
    return Uint8List.sublistView(data, 0, data.length - padLength);
  }
}
