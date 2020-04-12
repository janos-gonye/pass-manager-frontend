import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 130, 60, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  )
                )
              ],
            )
          )
        )
      )
    );
  }
}
