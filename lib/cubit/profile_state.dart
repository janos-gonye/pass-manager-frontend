part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

abstract class ProfileSuccess extends ProfileState {
  final Profile profile;
  const ProfileSuccess(this.profile);
}

abstract class ProfileInProgress extends ProfileState {
  const ProfileInProgress();
}

// Fetching
class ProfileInitial extends ProfileState {
  const ProfileInitial();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileInProgress {
  const ProfileLoading();
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final bool firstEncryption;
  final List<Profile> profiles;
  const ProfileLoaded(this.profiles, {this.firstEncryption = false});
  @override
  List<Object> get props => [profiles];
}

// Create
class ProfileAddding extends ProfileInProgress {
  const ProfileAddding();
  @override
  List<Object> get props => [];
}

class ProfileAdded extends ProfileSuccess {
  final Profile profile;
  const ProfileAdded(this.profile) : super(profile);
  @override
  List<Object> get props => [profile];
}

// Edit
class ProfileEditing extends ProfileInProgress {
  const ProfileEditing();
  @override
  List<Object> get props => [];
}

class ProfileEdited extends ProfileSuccess {
  final Profile profile;
  const ProfileEdited(this.profile) : super(profile);
  @override
  List<Object> get props => [profile];
}

// Delete
class ProfileDeleting extends ProfileInProgress {
  const ProfileDeleting();
  @override
  List<Object> get props => [];
}

class ProfileDeleted extends ProfileSuccess {
  final Profile profile;
  const ProfileDeleted(this.profile) : super(profile);
  @override
  List<Object> get props => [profile];
}

// Reencrypting
class ProfileReEncrypting extends ProfileInProgress {
  const ProfileReEncrypting();
  @override
  List<Object> get props => [];
}

class ProfileReEncrypted extends ProfileState {
  const ProfileReEncrypted();
  @override
  List<Object> get props => [];
}

// Error
class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object> get props => [message];
}
