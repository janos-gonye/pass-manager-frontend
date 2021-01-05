import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/components/forms/profile.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                profile.title,
                style: TextStyle(fontSize: 24),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("username: ${profile.username}"),
                  _Password(profile.password),
                  Text("notes: ${profile.notes}"),
                  Text("url: ${profile.url}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Scrollbar(
                                child: SingleChildScrollView(
                                    child: AlertDialog(
                                        title: Text('Edit account'),
                                        content: ProfileForm(
                                            profile: this.profile,
                                            callAfterSave: (Profile profile) {
                                              this.editCallback(profile);
                                            }))));
                          });
                    },
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    child: Icon(Icons.delete),
                    onPressed: () async {
                      CoolAlert.show(
                          context: context,
                          type: CoolAlertType.confirm,
                          confirmBtnText: "Delete",
                          cancelBtnText: "Cancel",
                          onConfirmBtnTap: () {
                            this.deleteCallback(profile);
                            Navigator.pop(context);
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _Password extends StatefulWidget {
  final String password;

  _Password(this.password, {Key key}) : super(key: key);

  @override
  __PasswordState createState() => __PasswordState();
}

class __PasswordState extends State<_Password> {
  bool displayPassword = false;
  bool passwordCopiedToClipboard = false;

  _copyPasswordToClipboard() {
    setState(() {
      passwordCopiedToClipboard = !passwordCopiedToClipboard;
    });
    if (passwordCopiedToClipboard) {
      Clipboard.setData(ClipboardData(text: widget.password));
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
      displayPassword = !displayPassword;
    });
    if (displayPassword) {
      Future.delayed(Duration(seconds: 5), () {
        // Only invoke if the password is still displayed.
        if (displayPassword) {
          _toggleDisplayPassword();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("password: "),
            Text(displayPassword ? widget.password : "*" * 6,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FlatButton(
              child: Icon(displayPassword
                  ? FontAwesomeIcons.eyeSlash
                  : FontAwesomeIcons.eye),
              onPressed: _toggleDisplayPassword,
            ),
            FlatButton(
              child: Icon(passwordCopiedToClipboard
                  ? FontAwesomeIcons.clipboardCheck
                  : FontAwesomeIcons.clipboard),
              onPressed:
                  passwordCopiedToClipboard ? null : _copyPasswordToClipboard,
            ),
          ],
        ),
      ],
    );
  }
}
