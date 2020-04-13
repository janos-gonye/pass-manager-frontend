import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_manager_frontend/models/settings.dart';
import 'package:pass_manager_frontend/services/settings.dart';

class SettingsForm extends StatefulWidget {
  final Function callAfterSave;

  const SettingsForm ({ Key key, this.callAfterSave }): super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String protocol = 'https';
  String host;
  int port;

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
              labelText: 'Hostname',
              hintText: 'server.example.com',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter hostname or IP address';
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
                Settings settings = new Settings(
                  protocol: protocol,
                  host: host,
                  port: port
                );
                SettingsService.saveSettings(settings);
                widget.callAfterSave();
              }
            },
            child: Text('Save')
          )
        ],
      )
    );
  }
}