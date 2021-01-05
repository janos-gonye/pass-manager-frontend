import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/pages/login.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/pages/master_pass.dart';
import 'package:pass_manager_frontend/pages/settings.dart';
import 'package:pass_manager_frontend/pages/profiles.dart';
import 'package:pass_manager_frontend/services/profile.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

class PasswordManagerApp extends StatefulWidget {
  PasswordManagerApp({Key key}) : super(key: key);

  @override
  _PasswordManagerAppState createState() => _PasswordManagerAppState();
}

class _PasswordManagerAppState extends State<PasswordManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.grey[800],
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.grey[800],
          )),
      initialRoute: constants.ROUTE_LOGIN,
      navigatorKey: navigatorKey,
      routes: {
        constants.ROUTE_LOGIN: (context) => LoginPage(),
        constants.ROUTE_SETTINGS: (context) => SettingsPage(),
        constants.ROUTE_MASTER_PASS: (context) => BlocProvider(
              create: (context) => ProfileCubit(ProfileRepository()),
              child: MasterPassPage(),
            ),
        constants.ROUTE_PROFILES: (context) => BlocProvider(
              create: (context) => ProfileCubit(ProfileRepository()),
              child: ProfilesPage(),
            ),
      },
    );
  }
}

void main() => runApp(OverlaySupport(child: PasswordManagerApp()));
