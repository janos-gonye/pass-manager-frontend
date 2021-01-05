import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/exceptions.dart' as exceptions;
import 'package:pass_manager_frontend/services/profile.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> getProfiles() async {
    try {
      emit(ProfileLoading());
      ProfilesResult profilesResult = await _profileRepository.getProfiles();
      final List<Profile> profiles = profilesResult.profiles;
      final bool firstEncryption = profilesResult.firstEncrypted;
      emit(ProfileLoaded(profiles, firstEncryption: firstEncryption));
    } on exceptions.WrongMasterPasswordException {
      emit(ProfileError("Wrong master password."));
    } on exceptions.ApiException catch (e) {
      emit(ProfileError('Error when loading profiles. Cause: ${e.message}'));
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      emit(ProfileAddding());
      await _profileRepository.saveProfile(profile);
      emit(ProfileAdded(profile));
    } on exceptions.ApiException catch (e) {
      emit(ProfileError('Error when saving profile. Cause: ${e.message}'));
    }
  }

  Future<void> editProfile(Profile profile) async {
    try {
      emit(ProfileEditing());
      await _profileRepository.editProfile(profile);
      emit(ProfileEdited(profile));
    } on exceptions.ApiException catch (e) {
      emit(ProfileError('Error when editing profile. Cause: ${e.message}'));
    }
  }

  Future<void> deleteProfile(Profile profile) async {
    try {
      emit(ProfileDeleting());
      await _profileRepository.deleteProfile(profile);
      emit(ProfileDeleted(profile));
    } on exceptions.ApiException catch (e) {
      emit(ProfileError('Error when deleting profile. Cause: ${e.message}'));
    }
  }

  /*
   * Call this method to reencrypt the profiles with a new master password.
   */
  Future<void> reEncryptProfiles(String newMaterPass) async {
    String oldMasterPass;
    try {
      emit(ProfileReEncrypting());
      oldMasterPass = ProfileCrypterStorageService.crypter.masterPassword;
      await _profileRepository.reEncryptProfiles(newMaterPass);
      emit(ProfileReEncrypted());
    } on exceptions.ApiException catch (e) {
      emit(ProfileError(
          'Error when reencrypting profiles. Old master password reset. Cause: ${e.message}'));
      ProfileCrypterStorageService.crypter.masterPassword = oldMasterPass;
    }
  }
}
