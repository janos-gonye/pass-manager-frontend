import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/pages/login.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/pages/master_pass.dart';
import 'package:pass_manager_frontend/pages/settings.dart';
import 'package:pass_manager_frontend/pages/profiles.dart';
import 'package:pass_manager_frontend/services/profile.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

class MyMaterialApp extends StatefulWidget {
  final ThemeData theme;

  MyMaterialApp({@required this.theme, Key key}) : super(key: key);

  @override
  _MyMaterialAppState createState() => _MyMaterialAppState();
}

class _MyMaterialAppState extends State<MyMaterialApp>
    with WidgetsBindingObserver {
  static bool _appSecured = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_appSecured) {
      await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      _appSecured = true;
    }
    // if (state == AppLifecycleState.inactive && SecurePageService.isSecurePage)
    //   Navigator.of(navigatorKey.currentState.context).pushNamedAndRemoveUntil(
    //     constants.ROUTE_LOGIN,
    //     (route) => false,
    //     arguments: {
    //       'message': 'You have been logged out for leaving the application.'
    //     },
    //   );
    super.didChangeAppLifecycleState(state);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      theme: widget.theme,
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

class PasswordManagerApp extends StatelessWidget {
  void initLoader() {
    EasyLoading.instance
      ..indicatorWidget = CircularProgressIndicator()
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      data: (Brightness brightness) {
        return brightness == Brightness.light
            ? FlexColorScheme.light(
                scheme: FlexScheme.hippieBlue,
              ).toTheme
            : FlexColorScheme.dark(
                scheme: FlexScheme.hippieBlue,
              ).toTheme;
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
        initLoader();
        return MyMaterialApp(theme: theme);
      },
    );
  }
}

void main() => runApp(PasswordManagerApp());
