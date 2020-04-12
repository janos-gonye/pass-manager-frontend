import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/pages/login.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/pages/settings.dart';

void main() => runApp(MaterialApp(
  initialRoute: constants.ROUTE_LOGIN,
  routes: {
    constants.ROUTE_LOGIN: (context) => LoginPage(),
    constants.ROUTE_SETTINGS: (context) => SettingsPage(),
  },
));
