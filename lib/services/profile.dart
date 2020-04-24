import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/models/profile_crypter.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/authorized_api.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/crypto.dart';

class ProfileService extends AuthorizedApiService {

  Future<bool> setProfiles({List<Profile> profiles, ProfileCrypter crypter}) async {
    final String encrypted = CryptoService().encrypt(
      textForEncryption: json.encode(profiles),
      symmetricKey: crypter.masterPassword);
    http.Response response = await post(constants.PATH_PROFILES, json.encode({
      'data': encrypted}));
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
        final String decrypted = CryptoService().decrypt(
          textForDecryption: encryptedProfiles,
          symmetricKey: crypter.masterPassword);
        final List<Profile> profiles = json.decode(decrypted);
        return profiles;
      }
    }
    // TODO: Handle other status codes and errors.
  }

  Future<bool> hasProfiles() async {
    final http.Response response = await get(constants.PATH_PROFILES);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final String encryptedProfiles = body['data'];
      if (encryptedProfiles == "") {
        return false;
      }
      return true;
    }
    // TODO: Handle other status codes and errors.
  }
}
