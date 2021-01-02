import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pass_manager_frontend/models/settings.dart';
import 'package:pass_manager_frontend/services/settings.dart';

class SettingsForm extends StatefulWidget {
  final Function callAfterSave;

  const SettingsForm({Key key, this.callAfterSave}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  Future<Settings> _settings;

  @override
  void initState() {
    super.initState();
    _settings = SettingsService.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Settings>(
        future: _settings,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Select protocol: '),
                        DropdownButton<String>(
                          value: snapshot.data.protocol,
                          onChanged: (String newProtocol) {
                            if (newProtocol == snapshot.data.protocol) {
                              return null;
                            }
                            setState(() {
                              snapshot.data.protocol = newProtocol;
                            });
                          },
                          items: <String>['http', 'https']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    TextFormField(
                      initialValue: snapshot.data.host,
                      decoration: InputDecoration(
                        labelText: 'Hostname',
                        hintText: 'server.example.com',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter hostname or IP address';
                        }
                        snapshot.data.host = value;
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: snapshot.data.port.toString(),
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
                        snapshot.data.port = int.parse(value);
                        return null;
                      },
                    ),
                    RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            SettingsService.saveSettings(snapshot.data);
                            widget.callAfterSave();
                          }
                        },
                        child: Text('Save')),
                  ],
                ));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return LinearProgressIndicator();
        });
  }
}
