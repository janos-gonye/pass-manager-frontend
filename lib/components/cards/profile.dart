import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfileCard extends StatelessWidget {
  Profile profile;

  ProfileCard(this.profile, {Key key}) : super(key: key);

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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}

class _Password extends StatefulWidget {
  String password;

  _Password(this.password, {Key key}) : super(key: key);

  @override
  __PasswordState createState() => __PasswordState();
}

class __PasswordState extends State<_Password> {
  String passwordText = "*" * 6;

  _copyPasswordToClipboard() {

  }

  _toogleHidePassword() {

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
            Text(passwordText, style: TextStyle(
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
              child: Icon(FontAwesomeIcons.eye),
              onPressed: _toogleHidePassword(),
            ),
            FlatButton(
              child: Icon(FontAwesomeIcons.clipboard),
              onPressed: _copyPasswordToClipboard(),
            ),
          ],
        ),
      ],
    );
  }
}
