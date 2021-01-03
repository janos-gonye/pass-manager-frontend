part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

abstract class ProfileSuccess extends ProfileState {
  final List<Profile> profiles;
  const ProfileSuccess(this.profiles);
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
  ProfileLoading();
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileSuccess {
  final List<Profile> profiles;
  const ProfileLoaded(this.profiles) : super(profiles);
  @override
  List<Object> get props => [profiles];
}

// Create
class ProfileAddding extends ProfileInProgress {
  ProfileAddding();
  @override
  List<Object> get props => [];
}

class ProfileAdded extends ProfileSuccess {
  final List<Profile> profiles;
  ProfileAdded(this.profiles) : super(profiles);
  @override
  List<Object> get props => [profiles];
}

// Edit
class ProfileEditing extends ProfileInProgress {
  ProfileEditing();
  @override
  List<Object> get props => [];
}

class ProfileEdited extends ProfileSuccess {
  final List<Profile> profiles;
  ProfileEdited(this.profiles) : super(profiles);
  @override
  List<Object> get props => [profiles];
}

// Delete
class ProfileDeleting extends ProfileInProgress {
  ProfileDeleting();
  @override
  List<Object> get props => [];
}

class ProfileDeleted extends ProfileSuccess {
  final List<Profile> profiles;
  ProfileDeleted(this.profiles) : super(profiles);
  @override
  List<Object> get props => [profiles];
}

// Error
class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object> get props => [message];
}
