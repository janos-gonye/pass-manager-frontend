import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileForm extends StatefulWidget {
  final Function callAfterSave;
  final Function callIfEmpty;

  ProfileForm({
    Key key, this.callAfterSave, this.callIfEmpty,
  }): super(key:key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final Profile _profile = Profile();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            validator: (value) {
              if (value.isEmpty)
              _profile.title = value;
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
            ),
            validator: (value) {
              _profile.title = value;
             return null;
            },
          ),
          TextFormField(
            autovalidate: true,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
            validator: (value) {
              _profile.password = value;
             return null;
            },
          ),
          TextFormField(
            autovalidate: true,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password repeat',
            ),
            validator: (value) {
              if (value.isEmpty && _profile.password.isNotEmpty) {
                return 'Please repeat password';
              } else if (_profile.password != value) {
                return "Passwords don't match";
              }
              return null;
            },
          ),
          TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Notes'
            ),
            validator: (value) {
              _profile.notes = value;
              return null;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'URL'
            ),
            validator: (value) {
              _profile.url = value;
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {

              }
            },
            child: Text('Save'),
          ),
        ],
      )
    );
  }
}
