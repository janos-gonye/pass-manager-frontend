import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/components/forms/profile.dart';
import 'package:pass_manager_frontend/services/profile.dart';
import 'package:pass_manager_frontend/models/profile.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, String> _pageArgs;
  final ProfileService _profileService = ProfileService();
  Future<List<Profile>> _profiles;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text(_pageArgs["message"]),
        duration: Duration(seconds: 2),
      )));
    // TODO: Handle when 'profiles' contains no empty list
    _profiles = _profileService.getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    _pageArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Scrollbar(
                child: SingleChildScrollView(
                  child: AlertDialog(
                    title: Text('Add new account'),
                    content: ProfileForm(
                      callAfterSave: (message) {
                        Navigator.of(context).pop();
                        _scaffoldKey.currentState.showSnackBar(
                          new SnackBar(
                            content: Text(message),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }, callIfEmpty: () {
                        Navigator.of(context).pop();
                      }),
                  )
                ),
              );
            }
          );
        },
        child: Icon(Icons.add),
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
                Center(
                  child: Text('Your\nAccounts',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
          )
        )
      )
    );
  }
}
