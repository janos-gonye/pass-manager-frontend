import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/models/auth_credential.dart';

class LoginForm extends StatefulWidget {
  final Function callAfterValidation;

  LoginForm({Key key, this.callAfterValidation}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
            controller: _usernameController,
            validator: (value) {
              if (value.isEmpty) return 'Please enter your username';
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            controller: _passwordController,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) return 'Please enter your password';
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await widget.callAfterValidation(AuthCredential(
                    username: _usernameController.text,
                    password: _passwordController.text));
              }
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
