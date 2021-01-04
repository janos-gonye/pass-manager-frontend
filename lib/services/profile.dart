import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:pass_manager_frontend/models/profile_crypter.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/authorized_api.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/crypto.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

class ProfileRepository extends AuthorizedApiService {
  Future<bool> _setProfiles(List<Profile> profiles) async {
    ProfileCrypter crypter = ProfileCrypterStorageService.crypter;
    final String encrypted = await CryptoService().symmetricEncrypt(
        stringForEncryption: json.encode(profiles),
        password: crypter.masterPassword);
    http.Response response =
        await patch(constants.PATH_PROFILES, {'data': encrypted});
    if (response.statusCode == 200) {
      return true;
    }
    // TODO: Handle other status codes and errors.
  }

  Future<List<Profile>> saveProfile(Profile profile) async {
    final ProfilesResult profilesResult = await getProfiles();
    List<Profile> profiles = profilesResult.profiles;
    profiles.add(profile);
    await _setProfiles(profiles);
    return profiles;
  }

  Future<List<Profile>> editProfile(Profile profile) async {
    final ProfilesResult profilesResult = await getProfiles();
    List<Profile> profiles = profilesResult.profiles;
    int index;
    for (var i = 0; i < profiles.length; i++) {
      if (profiles[i].id == profile.id) {
        index = i;
        break;
      }
    }
    profiles[index] = profile;
    await _setProfiles(profiles);
    return profiles;
  }

  Future<List<Profile>> deleteProfile(Profile profile) async {
    final ProfilesResult profilesResult = await getProfiles();
    List<Profile> profiles = profilesResult.profiles;
    int index;
    for (var i = 0; i < profiles.length; i++) {
      if (profiles[i].id == profile.id) {
        index = i;
        break;
      }
    }
    profiles.removeAt(index);
    await _setProfiles(profiles);
    return profiles;
  }

  Future<ProfilesResult> getProfiles() async {
    ProfileCrypter crypter = ProfileCrypterStorageService.crypter;
    final http.Response response = await get(constants.PATH_PROFILES);
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final String encryptedProfiles = body['data'];
      // This can only happen when the users logs in the first time.
      if (encryptedProfiles == "") {
        return ProfilesResult(profiles: [], firstEncrypted: true);
      } else {
        final String decrypted = await CryptoService().symmetricDecrypt(
            stringForDecryption: encryptedProfiles,
            password: crypter.masterPassword);
        final List parsedList = json.decode(decrypted);
        final List<Profile> profiles =
            parsedList.map((val) => Profile.fromJson(val)).toList();
        return ProfilesResult(profiles: profiles, firstEncrypted: false);
      }
    }
    // TODO: Handle other status codes and errors.
  }

  Future<List<Profile>> reEncryptProfiles(String newMasterPass) async {
    // Here the old master pass is being used
    final ProfilesResult profilesResult = await getProfiles();
    List<Profile> profiles = profilesResult.profiles;
    ProfileCrypterStorageService.crypter.masterPassword = newMasterPass;
    await _setProfiles(profiles);
    return profiles;
  }
}

class ProfilesResult {
  final List<Profile> profiles;
  final bool firstEncrypted;

  const ProfilesResult(
      {@required this.profiles, @required this.firstEncrypted});
}
