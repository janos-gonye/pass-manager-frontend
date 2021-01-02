import 'package:pass_manager_frontend/models/profile_crypter.dart';

/// This service is responsible for providing and storing
/// the profile crypter in memory for en/decrypting the users' profiles.
///
/// Usage:
/// ```
/// import 'package:pass_manager_frontend/models/profile_crypter.dart';
///
/// ProfileCrypter crypter = ProfileCrypter(masterPassword: "secret-key");
/// ProfileCrypterStorageService.crypter = crypter;
/// print(ProfileCrypterStorageService.crypter.masterPassword);
/// ```
class ProfileCrypterStorageService {
  static ProfileCrypter crypter = ProfileCrypter(masterPassword: "");

  static ProfileCrypter get() {
    if (crypter.masterPassword.isEmpty) {
      throw new ProfileCrypterUnsetException(
          "Nothing to return. The profile crypter is unset.");
    }
    return crypter;
  }

  static void set(ProfileCrypter value) {
    crypter = value;
  }
}

class ProfileCrypterUnsetException implements Exception {
  String cause;
  ProfileCrypterUnsetException(this.cause);
}
