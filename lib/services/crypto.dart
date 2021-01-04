import 'package:flutter/foundation.dart' as foundation;
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/utils/cryptojs_aes_encryption_helper.dart';

/// This service is responsible for symmetrically
/// crypting/decryipting data.
///
/// Typical usage:
/// ```
/// CryptoService cryptoService = CryptoService();
/// String encryptedText = cryptoService.encrypt(
///   stringForEncrytion: "some-text",
///   password: "secret-key")
/// String decryptedText = cryptoService.decrypt(
///   stringForDecryption: encryptedText,
///   password: "secret-key")
/// ```
class CryptoService {
  Future<String> symmetricEncrypt({
    @foundation.required String stringForEncryption,
    @foundation.required String password,
  }) async {
    return encryptAESCryptoJS(
        plainText: stringForEncryption, passphrase: password);
  }

  Future<String> symmetricDecrypt({
    @foundation.required String stringForDecryption,
    @foundation.required String password,
  }) async {
    try {
      return decryptAESCryptoJS(
          encrypted: stringForDecryption, passphrase: password);
    } on Error {
      throw new exceptions.WrongMasterPasswordException();
    }
  }
}
