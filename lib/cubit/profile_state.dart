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

// Create
class ProfileAddding extends ProfileState {
  const ProfileAddding();
  @override
  List<Object> get props => [];
}

class ProfileAdded extends ProfileState {
  final List<Profile> profiles;
  const ProfileAdded(this.profiles);
  @override
  List<Object> get props => [profiles];
}

// Edit
class ProfileEditing extends ProfileState {
  const ProfileEditing();
  @override
  List<Object> get props => [];
}

class ProfileEdited extends ProfileState {
  final List<Profile> profiles;
  const ProfileEdited(this.profiles);
  @override
  List<Object> get props => [profiles];
}

// Delete
class ProfileDeleting extends ProfileState {
  const ProfileDeleting();
  @override
  List<Object> get props => [];
}

class ProfileDeleted extends ProfileState {
  final List<Profile> profiles;
  const ProfileDeleted(this.profiles);
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
