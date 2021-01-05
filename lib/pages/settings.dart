import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/components/forms/settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(60, 130, 60, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        SettingsForm(callAfterSave: () {
                          Navigator.pop(context, {'message': 'Settings saved'});
                        }),
                      ],
                    )))));
  }
}
