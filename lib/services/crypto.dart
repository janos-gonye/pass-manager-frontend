import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';

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
  final _cryptor = PlatformStringCryptor();

  Future<String> symmetricEncrypt({
    @foundation.required String stringForEncryption,
    @foundation.required String password,
  }) async {
    final String key = await _generateNewKey(password);
    return await _cryptor.encrypt(stringForEncryption, key);
  }

  Future<String> symmetricDecrypt({
    @foundation.required String stringForDecryption,
    @foundation.required String password,
  }) async {
    final String key = await _generateKey(password);
    try {
      return await _cryptor.decrypt(stringForDecryption, key);
    } on MacMismatchException {
      // TODO: Handle (wrong key or forged data)
    }
  }

  // Generate a symmetric key, and store the used salt.
  Future<String> _generateNewKey(password) async {
    final String salt = await _cryptor.generateSalt();
    final String key = await _cryptor.generateKeyFromPassword(password, salt);
    _SaltSecuryStorage.setSalt(salt);
    return key;
  }

  /// Generate a symmetric key from the stored salt.
  Future<String> _generateKey(password) async {
    final String salt = await _SaltSecuryStorage.salt;
    return await _cryptor.generateKeyFromPassword(password, salt);
  }
}

// TODO: Use ASE encryption.
class _SaltSecuryStorage {
  static final _secureStorage = FlutterSecureStorage();
  static const _saltName = 'salt';

  static setSalt(String value) {
    _secureStorage.write(key: _saltName, value: value);
  }

  static Future<String> get salt async {
    return await _secureStorage.read(key: _saltName);
  }
}
