part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

// Fetching
class ProfileInitial extends ProfileState {
  const ProfileInitial();
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileState {
  final List<Profile> profiles;
  const ProfileLoaded(this.profiles);
  @override
  List<Object> get props => [profiles];
}

// Saving/editing
class ProfileSaving extends ProfileState {
  const ProfileSaving();
  @override
  List<Object> get props => [];
}

class ProfileSaved extends ProfileState {
  const ProfileSaved();
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
