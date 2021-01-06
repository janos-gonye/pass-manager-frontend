import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pass_manager_frontend/components/forms/settings.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  DynamicTheme.of(context).setBrightness(
                      Theme.of(context).brightness == Brightness.dark
                          ? Brightness.light
                          : Brightness.dark);
                },
                child: Icon(FontAwesomeIcons.palette),
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
              ),
            ],
          ),
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
