import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileCard extends StatefulWidget {
  Profile profile;

  ProfileCard(this.profile, {Key key}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.profile.title);
  }
}
