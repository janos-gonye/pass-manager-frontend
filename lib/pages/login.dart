import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/components/forms/login.dart';
import 'package:pass_manager_frontend/models/auth_credential.dart';
import 'package:pass_manager_frontend/pages/settings.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/auth.dart';
import 'package:pass_manager_frontend/services/exceptions.dart';
import 'package:pass_manager_frontend/services/secure_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();

  Map<String, String> _pageArgs = {};

  void initState() {
    super.initState();
    SecurePageService.isSecurePage = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageArgs = ModalRoute.of(context).settings.arguments;
      if (_pageArgs != null && _pageArgs.containsKey("message"))
        _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(_pageArgs["message"]),
            duration: Duration(seconds: 2)));
    });
  }

  _navigateToSettingsAndShowMessage(BuildContext context) async {
    final Map<String, String> result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
    if (result != null && result.containsKey("message")) {
      String message = result['message'];
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("$message"), duration: Duration(seconds: 2)));
    }
  }

  void showLoginError(String errorMessage) {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(errorMessage), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        // Use a 'Builder' to avoid an error related to 'Scaffold.of'.
        // See more by visiting the following URL.
        // https://api.flutter.dev/flutter/material/Scaffold/of.html#material.Scaffold.of.2
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () {
                _navigateToSettingsAndShowMessage(context);
              },
              child: Icon(Icons.settings),
            );
          },
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 130, 60, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'PassMan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
              ),
              Text(
                'your password manager',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: 20),
              Icon(
                FontAwesomeIcons.key,
                size: 80,
              ),
              SizedBox(height: 20),
              LoginForm(
                  callAfterValidation: (AuthCredential authCredential) async {
                try {
                  await _authService.login(authCredential);
                  Navigator.pushReplacementNamed(
                    context,
                    constants.ROUTE_MASTER_PASS,
                    arguments: {
                      'message': "Successfully logged in",
                    },
                  );
                } on UnAuthenticatedException {
                  showLoginError("Invalid credentials");
                } on ApiException catch (e) {
                  showLoginError(e.message);
                }
              }),
            ],
          ),
        ))));
  }
}
