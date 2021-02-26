import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/components/forms/profile.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileCard extends StatefulWidget {
  final Profile profile;
  final Function deleteCallback;
  final Function editCallback;

  ProfileCard(
      {@required this.profile,
      @required this.deleteCallback,
      @required this.editCallback,
      Key key})
      : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  bool _displayPassword = false;
  bool _passwordCopiedToClipboard = false;

  _copyPasswordToClipboard() {
    setState(() {
      _passwordCopiedToClipboard = !_passwordCopiedToClipboard;
    });
    if (_passwordCopiedToClipboard) {
      Clipboard.setData(ClipboardData(text: widget.profile.password));
      Scaffold.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Password copied to clipboard')));
      Future.delayed(Duration(milliseconds: 2250), () {
        _copyPasswordToClipboard();
      });
    }
  }

  _toggleDisplayPassword() {
    setState(() {
      _displayPassword = !_displayPassword;
    });
    if (_displayPassword) {
      Future.delayed(Duration(seconds: 5), () {
        // Only invoke if the password is still displayed.
        if (_displayPassword) {
          _toggleDisplayPassword();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Scrollbar(
                  child: SingleChildScrollView(
                      child: AlertDialog(
                    title: Text('Edit account'),
                    content: ProfileForm(
                        profile: widget.profile,
                        callAfterSave: (Profile profile) {
                          widget.editCallback(profile);
                        }),
                  )),
                );
              },
            );
          },
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.profile.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Tap to edit',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("username: ${widget.profile.username}"),
                Divider(),
                Text(
                    "password: ${_displayPassword ? widget.profile.password : "*" * 6}"),
                Divider(),
                Text("notes: ${widget.profile.notes}",
                    style: TextStyle(fontStyle: FontStyle.italic)),
                Divider(),
                Text("url: ${widget.profile.url}"),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(2, 4, 4, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.delete, size: 17),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Scrollbar(
                                child: SingleChildScrollView(
                                    child: AlertDialog(
                              title: Text('Delete account'),
                              content: Column(children: [
                                Text('Are you sure to delete?'),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RaisedButton(
                                      child: Text('Cancel'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                    RaisedButton(
                                        child: Text('Delete',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            )),
                                        onPressed: () {
                                          widget.deleteCallback(widget.profile);
                                          Navigator.pop(context);
                                        }),
                                  ],
                                )
                              ]),
                            ))),
                          );
                        });
                  },
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(
                      _displayPassword
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      size: 17),
                  onPressed: _toggleDisplayPassword,
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(
                    _passwordCopiedToClipboard
                        ? FontAwesomeIcons.clipboardCheck
                        : FontAwesomeIcons.clipboard,
                    size: 17,
                  ),
                  onPressed: _passwordCopiedToClipboard
                      ? null
                      : _copyPasswordToClipboard,
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: FloatingActionButton(
                  heroTag: null,
                  child: Icon(
                    Icons.edit,
                    size: 17,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Scrollbar(
                          child: SingleChildScrollView(
                              child: AlertDialog(
                            title: Text('Edit account'),
                            content: ProfileForm(
                                profile: widget.profile,
                                callAfterSave: (Profile profile) {
                                  widget.editCallback(profile);
                                }),
                          )),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
