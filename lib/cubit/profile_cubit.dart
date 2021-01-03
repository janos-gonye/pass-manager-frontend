import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/profile.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  Future<void> getProfiles() async {
    try {
      emit(ProfileLoading());
      final List<Profile> profiles = await _profileRepository.getProfiles();
      emit(ProfileLoaded(profiles));
    } on Error {
      emit(ProfileError('Error when loading profiles.'));
    }
  }

  Future<void> addProfile(Profile profile) async {
    try {
      emit(ProfileAddding());
      List<Profile> profiles = await _profileRepository.saveProfile(profile);
      emit(ProfileAdded(profiles));
    } on Error {
      emit(ProfileError('Error when saving profile.'));
    }
  }

  Future<void> editProfile(Profile profile) async {
    try {
      emit(ProfileEditing());
      List<Profile> profiles = await _profileRepository.editProfile(profile);
      emit(ProfileEdited(profiles));
    } on Error {
      emit(ProfileError('Error when editing profile.'));
    }
  }

  Future<void> deleteProfile(Profile profile) async {
    try {
      emit(ProfileDeleting());
      List<Profile> profiles = await _profileRepository.deleteProfile(profile);
      emit(ProfileDeleted(profiles));
    } on Error {
      emit(ProfileError('Error when deleting profile.'));
    }
  }
}