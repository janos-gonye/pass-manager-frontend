import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/models/profile_crypter.dart';
import 'package:pass_manager_frontend/services/profile_crypter_storage.dart';

class MasterPassForm extends StatefulWidget {
  MasterPassForm({Key key}) : super(key: key);

  @override
  _MasterPassFormState createState() => _MasterPassFormState();
}

class _MasterPassFormState extends State<MasterPassForm> {
  final _formKey = GlobalKey<FormState>();
  final _masterPassController = TextEditingController();

  @override
  void dispose() {
    _masterPassController.dispose();
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
              labelText: 'Unlock your profiles',
              hintText: 'Your master password',
            ),
            controller: _masterPassController,
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter your master password';
              }
              return null;
            },
          ),
          RaisedButton(
            child: Text("Unlock"),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                ProfileCrypterStorageService.crypter =
                    ProfileCrypter(masterPassword: _masterPassController.text);
                BlocProvider.of<ProfileCubit>(context).getProfiles();
              }
            },
          ),
        ],
      ),
    );
  }
}
