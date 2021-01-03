import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/models/profile.dart';
import 'package:uuid/uuid.dart';

class ProfileForm extends StatefulWidget {
  final Function callAfterSave;
  final Profile profile;

  ProfileForm({Key key, this.profile, @required this.callAfterSave})
      : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRepeatController = TextEditingController();
  final _notesController = TextEditingController();
  final _urlController = TextEditingController();
  bool editForm = false;

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    _notesController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  _fillFormWithProfileToBeEdited() {
    _titleController.text = widget.profile.title;
    _usernameController.text = widget.profile.username;
    _passwordController.text = widget.profile.password;
    _passwordRepeatController.text = widget.profile.password;
    _notesController.text = widget.profile.notes;
    _urlController.text = widget.profile.url;
  }

  void initState() {
    super.initState();
    if (widget.profile != null) {
      _fillFormWithProfileToBeEdited();
      editForm = true;
    }
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
              controller: _passwordRepeatController,
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
                      String id;
                      if (editForm) {
                        id = widget.profile.id;
                      } else {
                        id = Uuid().v4();
                      }
                      widget.callAfterSave(Profile(
                        id: id,
                        title: _titleController.text,
                        username: _usernameController.text,
                        password: _passwordController.text,
                        notes: _notesController.text,
                        url: _urlController.text,
                      ));
                      Navigator.pop(context);
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
