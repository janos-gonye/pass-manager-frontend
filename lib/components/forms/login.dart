import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/models/auth_credential.dart';
import 'package:pass_manager_frontend/services/auth.dart';

class LoginForm extends StatefulWidget {
  final Function callAfterSuccess;

  LoginForm({Key key, this.callAfterSuccess}): super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final AuthCredential _authCredential = AuthCredential(username: "", password: "");
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your username';
              }
              _authCredential.username = value;
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your password';
              }
              _authCredential.password = value;
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                bool success = await _authService.login(_authCredential);
                if (success) {
                  widget.callAfterSuccess();
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Invalid credentials"),
                      duration: Duration(seconds: 2),
                    )
                  );
                }
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
