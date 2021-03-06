import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

class ChangeMasterPassForm extends StatefulWidget {
  final Function changeCallback;

  ChangeMasterPassForm({Key key, @required this.changeCallback})
      : super(key: key);

  @override
  _ChangeMasterPassFormState createState() => _ChangeMasterPassFormState();
}

class _ChangeMasterPassFormState extends State<ChangeMasterPassForm> {
  final _formKey = GlobalKey<FormState>();
  final _newKeyController = TextEditingController();

  @override
  void dispose() {
    _newKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
                autovalidate: true,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Current key *'),
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please enter the current encryption key';
                  if (value.isNotEmpty &&
                      value !=
                          ProfileCrypterStorageService.crypter.masterPassword)
                    return "Doesn't match.";
                  return null;
                }),
            TextFormField(
              obscureText: true,
              controller: _newKeyController,
              decoration: InputDecoration(labelText: 'New key *'),
              validator: (value) {
                if (value.isEmpty) return 'Please enter the new encryption key';
                return null;
              },
            ),
            TextFormField(
                autovalidate: true,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Repeat new key *'),
                validator: (value) {
                  if (_newKeyController.text.isNotEmpty && value.isEmpty)
                    return 'Please repeat the new encryption key *';
                  else if (_newKeyController.text.isNotEmpty &&
                      value != _newKeyController.text)
                    return "Keys don't match";
                  return null;
                }),
            SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              RaisedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              RaisedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    widget.changeCallback(_newKeyController.text);
                    Navigator.pop(context);
                  }
                },
              )
            ]),
          ],
        ));
  }
}
