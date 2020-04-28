import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/components/forms/master_pass.dart';
import 'package:pass_manager_frontend/constants.dart' as constants;

class MasterPassPage extends StatefulWidget {
  @override
  _MasterPassPageState createState() => _MasterPassPageState();
}

class _MasterPassPageState extends State<MasterPassPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, String> _pageArgs;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(_pageArgs["message"]),
              duration: Duration(seconds: 2),
            )));
  }

  @override
  Widget build(BuildContext context) {
    _pageArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60, 130, 60, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              MasterPassForm(callAfterSuccess: () {
                Navigator.pushReplacementNamed(
                  context, constants.ROUTE_PROFILES, arguments: {
                    "message": "Profiles successfully unlocked"
                  });
                }
              ),
              SizedBox(height: 15),
              Text(
                "This password gets used " +
                "to encrypt/decrypt your data." +
                "Do not forget it, because there is " +
                "no other way to recover your data.",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
