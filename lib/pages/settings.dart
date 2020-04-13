import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/components/forms/settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.grey[800],
      ),
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
                ),
                SettingsForm(),
              ],
            )
          )
        )
      )
    );
  }
}
