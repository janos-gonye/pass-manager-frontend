import 'package:flutter/material.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.grey[800],
      ),
      body: Center(child: Text("Profiles page")),
    );
  }
}
