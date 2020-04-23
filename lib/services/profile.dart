import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart';
import 'package:pass_manager_frontend/models/profile_crypter.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/authorized_api.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;

class ProfileService extends AuthorizedApiService {

  Future<bool> setProfiles({List<Profile> profiles, ProfileCrypter crypter}) async {
    final String encryptedProfiles = json.encode(profiles);
    final Key key = Key.fromUtf8(crypter.masterPassword);
    final Encrypter encrypter = Encrypter(AES(key));
    final IV iv = IV.fromLength(16);
    final Encrypted encrypted = encrypter.encrypt(encryptedProfiles, iv: iv);
    http.Response response = await post(constants.PATH_PROFILES, json.encode({
      'data': encrypted.base64
    }));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
    // TODO: Handle other status codes and errors.
  }

  Future<List<Profile>> getProfiles({ProfileCrypter crypter}) async {
    final http.Response response = await get(constants.PATH_PROFILES);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final String encryptedProfiles = body['data'];
      // TODO: Change it to 'null'. Both here and in the back-end, too.
      if (encryptedProfiles == "") {
        return [];
      } else {
        final Key key = Key.fromUtf8(crypter.masterPassword);
        final IV iv = IV.fromLength(16);
        final Encrypter encrypter = Encrypter(AES(key));
        final Encrypted encrypted = Encrypted.fromBase64(encryptedProfiles);
        final String decrypted = encrypter.decrypt(encrypted, iv: iv);
        final List<Profile> profiles = json.decode(decrypted);
        return profiles;
      }
    }
    // TODO: Handle other status codes and errors.
  }
}
