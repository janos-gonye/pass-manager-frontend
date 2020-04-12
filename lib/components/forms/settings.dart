import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String protocol = 'https';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Select protocol: ',
              ),
              DropdownButton<String>(
                value: protocol,
                onChanged: (String newProtocol) {
                  if (newProtocol == protocol) {
                    return null;
                  }
                  setState(() {
                    protocol = newProtocol;
                    print(protocol);
                  });
                },
                items: <String>['http', 'https'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
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
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly,
            ],
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