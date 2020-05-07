part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfilesInitial extends ProfileState {
  const ProfilesInitial();
  @override
  List<Object> get props => [];
}

class ProfilesLoading extends ProfileState {
  const ProfilesLoading();
  @override
  List<Object> get props => [];
}

class ProfilesLoaded extends ProfileState {
  final List<Profile> profiles;
  const ProfilesLoaded(this.profiles);
  @override
  List<Object> get props => [profiles];
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object> get props => [message];
}
