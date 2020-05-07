import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:pass_manager_frontend/services/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService repository;

  ProfileBloc(this.repository);

  @override
  ProfileState get initialState => ProfilesInitial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    yield ProfilesLoading();
    if (event is GetProfiles) {
      try {
        final List<Profile> profiles = await repository.getProfiles();
        yield ProfilesLoaded(profiles);
      } on NetworkError {
        yield ProfileError('Error when loading profiles.');
      }
    }
  }
}

class NetworkError extends Error {}
