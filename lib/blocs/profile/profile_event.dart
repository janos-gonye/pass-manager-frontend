part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfiles extends ProfileEvent {
  const GetProfiles();

  @override
  List<Object> get props => [];
}

class AddProfile extends ProfileEvent {
  final Profile profile;
  
  const AddProfile(this.profile);

  @override
  List<Object> get props => [profile];
}
