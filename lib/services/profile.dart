import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/models/profile_crypter.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/authorized_api.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/crypto.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

class ProfileService extends AuthorizedApiService {
  Future<bool> _setProfiles(List<Profile> profiles) async {
    ProfileCrypter crypter = ProfileCrypterStorageService.crypter;
    final String encrypted = await CryptoService().symmetricEncrypt(
        stringForEncryption: json.encode(profiles),
        password: crypter.masterPassword);
    http.Response response =
        await patch(constants.PATH_PROFILES, {'data': encrypted});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    // TODO: Handle other status codes and errors.
  }

  Future<bool> saveProfile(Profile profile) async {
    List<Profile> profiles = await getProfiles();
    print(profiles);
    profiles.add(profile);
    print(profiles);
    return await _setProfiles(profiles);
  }

  Future<List<Profile>> getProfiles() async {
    ProfileCrypter crypter = ProfileCrypterStorageService.crypter;
    final http.Response response = await get(constants.PATH_PROFILES);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final String encryptedProfiles = body['data'];
      // TODO: Change it to 'null'. Both here and in the back-end, too.
      if (encryptedProfiles == "") {
        return [];
      } else {
        final String decrypted = await CryptoService().symmetricDecrypt(
            stringForDecryption: encryptedProfiles,
            password: crypter.masterPassword);
        final List parsedList = json.decode(decrypted);
        final List<Profile> profiles =
            parsedList.map((val) => Profile.fromJson(val)).toList();
        return profiles;
      }
    }
    // TODO: Handle other status codes and errors.
  }
}
