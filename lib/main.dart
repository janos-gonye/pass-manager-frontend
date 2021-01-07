import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/pages/login.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/pages/master_pass.dart';
import 'package:pass_manager_frontend/pages/settings.dart';
import 'package:pass_manager_frontend/pages/profiles.dart';
import 'package:pass_manager_frontend/services/profile.dart';
import 'package:pass_manager_frontend/theme_data.dart' as themes;

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

class PasswordManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (Brightness brightness) {
        return brightness == Brightness.light
            ? themes.lightThemeData
            : themes.darkThemeData;
      },
      themedWidgetBuilder: (context, theme) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: theme.snackBarTheme.backgroundColor,
          statusBarColor: theme.canvasColor,
          statusBarIconBrightness: theme.brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          systemNavigationBarIconBrightness:
              theme.brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ));
        return OverlaySupport(
          child: MaterialApp(
            theme: theme,
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
          ),
        );
      },
    );
  }
}

void main() => runApp(PasswordManagerApp());
