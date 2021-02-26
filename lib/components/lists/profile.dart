import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pass_manager_frontend/components/cards/profile.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileList extends StatefulWidget {
  final _ProfileListState _profileListState = _ProfileListState();
  final Function onDeleteProfile;
  final Function onEditProfile;

  ProfileList({@required this.onEditProfile, @required this.onDeleteProfile})
      : super();

  void listProfiles(List<Profile> profiles) =>
      _profileListState.listProfiles(profiles);

  void addProfile(Profile profile) => _profileListState.addProfile(profile);

  void editProfile(Profile profile) => _profileListState.editProfile(profile);

  void removeProfile(Profile profile) =>
      _profileListState.removeProfile(profile);

  @override
  _ProfileListState createState() => _profileListState;
}

class _ProfileListState extends State<ProfileList> {
  List<Profile> _profiles = [];

  void listProfiles(List<Profile> profiles) {
    setState(() {
      _profiles = profiles;
    });
  }

  int _getIndexOf(Profile profile) {
    for (int i = 0; i < _profiles.length; i++) {
      if (_profiles[i].id == profile.id) return i;
    }
    return null;
  }

  void addProfile(Profile profile) {
    setState(() => _profiles.add(profile));
  }

  void editProfile(Profile profile) {
    int i = _getIndexOf(profile);
    setState(() => _profiles[i] = profile);
  }

  void removeProfile(Profile profile) {
    int i = _getIndexOf(profile);
    setState(() => _profiles.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _profiles.length,
        itemBuilder: (BuildContext context, int index) => ProfileCard(
            profile: _profiles[index],
            editCallback: (Profile profile) {
              widget.onEditProfile(profile);
            }));
  }
}
