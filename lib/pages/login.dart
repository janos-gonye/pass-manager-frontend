import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/components/forms/login.dart';
import 'package:pass_manager_frontend/models/auth_credential.dart';
import 'package:pass_manager_frontend/pages/settings.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;
import 'package:pass_manager_frontend/services/auth.dart';
import 'package:pass_manager_frontend/services/exceptions.dart';

class LoginPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey();
  final AuthService _authService = AuthService();

  _navigateToSettingsAndShowMessage(BuildContext context) async {
    final Map<String, String> result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
    if (result.containsKey("message")) {
      String message = result['message'];
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            content: Text("$message"), duration: Duration(seconds: 2)));
    }
  }

  void showLoginError(String errorMessage) {
    (_scaffoldKey.currentState as ScaffoldState).showSnackBar(
        SnackBar(content: Text(errorMessage), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
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
              backgroundColor: Colors.grey[800],
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
                'Johnny\'s\nPassword\nManager',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              Icon(
                Icons.vpn_key,
                color: Colors.grey[800],
                size: 120,
              ),
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
