part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class GetProfiles extends ProfileEvent {
  const GetProfiles();

  @override
  List<Object> get props => [];
}
