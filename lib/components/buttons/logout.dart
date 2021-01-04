import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/services/auth.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: () {
        AuthService.logout();
        Navigator.pushNamedAndRemoveUntil(
            context, constants.ROUTE_LOGIN, (context) => false);
      },
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: Icon(FontAwesomeIcons.signOutAlt),
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}
