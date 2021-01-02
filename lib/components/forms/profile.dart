import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pass_manager_frontend/cubit/profile_cubit.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:uuid/uuid.dart';

class ProfileForm extends StatefulWidget {
  ProfileForm({Key key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _notesController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _notesController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title *',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              autovalidate: true,
              obscureText: true,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
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
                if (value.isEmpty && _passwordController.text.isNotEmpty) {
                  return 'Please repeat password';
                } else if (_passwordController.text != value) {
                  return "Passwords don't match";
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: 3,
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Notes'),
              validator: (value) {
                return null;
              },
            ),
            TextFormField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'URL'),
              validator: (value) {
                return null;
              },
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Back'),
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pop();
                      BlocProvider.of<ProfileCubit>(context).addProfile(Profile(
                        id: Uuid().v4(),
                        title: _titleController.text,
                        username: _usernameController.text,
                        password: _passwordController.text,
                        notes: _notesController.text,
                        url: _urlController.text,
                      ));
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            )
          ],
        ));
  }
}
