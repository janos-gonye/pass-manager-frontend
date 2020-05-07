import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_manager_frontend/blocs/profile/profile_bloc.dart';
import 'package:pass_manager_frontend/models/profile_crypter.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

class MasterPassForm extends StatefulWidget {

  MasterPassForm({Key key}): super(key: key);

  @override
  _MasterPassFormState createState() => _MasterPassFormState();
}

class _MasterPassFormState extends State<MasterPassForm> {
  final _formKey = GlobalKey<FormState>();
  final ProfileCrypter _crypter = ProfileCrypter(masterPassword: "");

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
              labelText: 'Unlock your profiles',
              hintText: 'Your master password',
            ),
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your master password';
              }
              _crypter.masterPassword = value;
              return null;
            },
          ),
          RaisedButton(
            child: Text("Unlock"),
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                ProfileCrypterStorageService.crypter = _crypter;
                BlocProvider.of<ProfileBloc>(context).add(GetProfiles());
              }
            },
          ),
        ],
      ),
    );
  }
}
