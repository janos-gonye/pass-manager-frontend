import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/auth.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(FontAwesomeIcons.signOutAlt),
        backgroundColor: Colors.grey[800],
        onPressed: () {
          AuthService.deleteAccessToken();
          AuthService.deleteRefreshToken();
          Navigator.pushReplacementNamed(context, constants.ROUTE_LOGIN);
        });
  }
}
