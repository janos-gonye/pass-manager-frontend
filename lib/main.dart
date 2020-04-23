import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/pages/login.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/pages/master_pass.dart';
import 'package:pass_manager_frontend/pages/settings.dart';
import 'package:pass_manager_frontend/pages/profiles.dart';

void main() => runApp(MaterialApp(
  initialRoute: constants.ROUTE_LOGIN,
  routes: {
    constants.ROUTE_LOGIN: (context) => LoginPage(),
    constants.ROUTE_SETTINGS: (context) => SettingsPage(),
    constants.ROUTE_MASTER_PASS: (context) => MasterPassPage(),
    constants.ROUTE_PROFILES: (context) => ProfilesPage(),
  },
));
