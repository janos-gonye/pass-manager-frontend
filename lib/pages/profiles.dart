import 'package:flutter/material.dart';
import 'package:pass_manager_frontend/components/cards/profile.dart';
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
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Scrollbar(
                  child: SingleChildScrollView(
                      child: AlertDialog(
                    title: Text('Add new account'),
                    content: ProfileForm(callAfterSave: (message) {
                      Navigator.of(context).pop();
                      _scaffoldKey.currentState.showSnackBar(
                        new SnackBar(
                          content: Text(message),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }, callIfCancelled: () {
                      Navigator.of(context).pop();
                    }),
                  )),
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey[800],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Your\nAccounts',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey[800]),
              Expanded(
                child: FutureBuilder<List<Profile>>(
                    future: _profileService.getProfiles(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      List<Profile> profiles = snapshot.data;
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: profiles.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ProfileCard(profiles[index]);
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error));
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
