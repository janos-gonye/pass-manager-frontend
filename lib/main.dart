import 'package:flutter/cupertino.dart';
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
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Open Sans',
        brightness: Brightness.light,
        buttonColor: Colors.white,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          splashColor: Colors.blueGrey[700],
          buttonColor: Colors.blueGrey[800],
          disabledColor: Colors.blueGrey[900],
          focusColor: Colors.blueGrey[900],
          highlightColor: Colors.blueGrey[650],
          colorScheme: ColorScheme.light(),
        ),
        accentColor: Colors.pinkAccent[500],
        cursorColor: Colors.blueGrey[800],
        disabledColor: Colors.blueGrey[900],
        primaryColor: Colors.blueGrey[800],
        dividerColor: Colors.pinkAccent[200],
        focusColor: Colors.blueGrey[800],
        highlightColor: Colors.blueGrey[800],
        splashColor: Colors.blueGrey[800],
        primaryColorLight: Colors.blueGrey[800],
        primaryColorDark: Colors.blueGrey[800],
        hintColor: Colors.blueGrey[800],
        hoverColor: Colors.blueGrey[800],
        primarySwatch: Colors.pink,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          splashColor: Colors.blueGrey[700],
          hoverColor: Colors.blueGrey[800],
          focusColor: Colors.blueGrey[900],
          backgroundColor: Colors.blueGrey[800],
        ),
        indicatorColor: Colors.blueGrey[800],
        errorColor: Colors.pinkAccent[200],
        iconTheme: IconThemeData(color: Colors.blueGrey[800]),
        snackBarTheme: SnackBarThemeData(
          actionTextColor: Colors.white,
          backgroundColor: Colors.blueGrey[900],
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.blueGrey[800],
        ),
        cardTheme: CardTheme(
          shadowColor: Colors.blueGrey[800],
          elevation: 4,
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: 'Open Sans',
        brightness: Brightness.dark,
        buttonColor: Colors.white,
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          splashColor: constants.darkThemePrimary,
          buttonColor: constants.darkThemePrimary,
          disabledColor: constants.darkThemePrimary,
          highlightColor: constants.darkThemePrimary,
          focusColor: constants.darkThemePrimary,
          colorScheme: ColorScheme.dark(),
        ),
        textSelectionColor: constants.darkThemePrimary,
        textSelectionHandleColor: constants.darkThemePrimary,
        canvasColor: constants.darkThemeBackground,
        accentColor: constants.darkThemePrimary,
        cursorColor: constants.darkThemeSecondary,
        disabledColor: constants.darkThemeSecondary,
        dialogBackgroundColor: constants.darkThemeBackground,
        primaryColor: constants.darkThemeSecondary,
        dividerColor: constants.darkThemePrimary,
        focusColor: constants.darkThemeSecondary,
        highlightColor: constants.darkThemeForeground,
        splashColor: constants.darkThemeForeground,
        primaryColorLight: constants.darkThemeSecondary,
        primaryColorDark: constants.darkThemeBackground,
        hintColor: constants.darkThemeSecondary,
        hoverColor: constants.darkThemePrimary,
        primarySwatch: Colors.pink,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          splashColor: constants.darkThemePrimary,
          hoverColor: constants.darkThemePrimary,
          focusColor: constants.darkThemePrimary,
          backgroundColor: constants.darkThemePrimary,
        ),
        errorColor: constants.darkThemePrimary,
        iconTheme: IconThemeData(color: constants.darkThemeForeground),
        snackBarTheme: SnackBarThemeData(
          contentTextStyle: TextStyle(color: constants.darkThemeSecondary),
          actionTextColor: constants.darkThemeSecondary,
          backgroundColor: constants.darkThemeForeground,
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        cardTheme: CardTheme(
          color: constants.darkThemeForeground,
          shadowColor: constants.darkThemeForeground,
          elevation: 4,
        ),
      ),
      themeMode: _themeMode,
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
