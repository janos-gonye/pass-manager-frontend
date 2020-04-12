import 'package:flutter/material.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

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
              labelText: 'Server URL',
              hintText: 'server.example.com',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter server URL';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Port number',
              hintText: 'generally 443 for HTTPS',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter port number';
              }
              return null;
            },
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Save Settings'))
                );
              }
            },
            child: Text('Save')
          )
        ],
      )
    );
  }
}