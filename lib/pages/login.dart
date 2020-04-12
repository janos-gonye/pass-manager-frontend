import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/forms/login.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, constants.ROUTE_SETTINGS);
        },
        child: Icon(Icons.settings),
        backgroundColor: Colors.grey[800],
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 130, 60, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Johnny\'s\nPassword\nManager',
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
                LoginForm(),
              ],
            ),
          )
        )
      )
    );
  }
}
