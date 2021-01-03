import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final Function deleteCallback;

  ProfileCard({@required this.profile, @required this.deleteCallback, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Row(
                children: <Widget>[
                  Icon(Icons.vpn_key),
                  SizedBox(width: 4),
                  Text(profile.title),
                ],
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
                    textColor: Colors.grey[800],
                    child: Icon(Icons.edit),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  FlatButton(
                    textColor: Colors.grey[800],
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
  String password;

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
                  color: Colors.grey[800],
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
