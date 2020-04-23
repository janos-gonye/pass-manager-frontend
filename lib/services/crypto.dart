import 'package:encrypt/encrypt.dart';
import 'package:flutter/foundation.dart' as foundation;

class CryptoService {
  String encrypt({
    @foundation.required String textForEncryption,
    @foundation.required String symmetricKey,
  }) {
    final Key key = Key.fromUtf8(symmetricKey);
    final Encrypter encrypter = Encrypter(AES(key));
    final IV iv = IV.fromLength(16);
    final Encrypted encrypted = encrypter.encrypt(textForEncryption, iv: iv);
    return encrypted.base64;
  }

  String decrypt({
    @foundation.required String textForDecryption,
    @foundation.required String symmetricKey,
  }) {
    final Key key = Key.fromUtf8(symmetricKey);
    final IV iv = IV.fromLength(16);
    final Encrypter encrypter = Encrypter(AES(key));
    final Encrypted encrypted = Encrypted.fromBase64(textForDecryption);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
